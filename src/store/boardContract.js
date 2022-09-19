import { ethers } from "ethers";
import { writable, derived } from "svelte/store";
import { abi as BoardAbi } from "../../artifacts/Board.sol/Board.json";

export default function boardContract(address, provider) {
  const { subscribe } = derived(provider, (provider) => new ethers.Contract(address, BoardAbi, provider.getSigner()))

  function posts() {
    const { subscribe: subscribePosts, set, update } = writable([]);

    function append(...args) {
      update((events) => {
        const event = args[args.length - 1];
        if (events[events.length - 1].transactionHash === event.transactionHash) {
          // Sometimes there is an event that was already sent...
          return events;
        }
        return [...events, args[args.length - 1]]
      });
    }

    subscribe((contract) => {
      set([]);
      const event = contract.filters.PostedText();
      contract.queryFilter(event).then(set);
      contract.on(event, append);
      return () => contract.off(event, append);
    });

    return { subscribe: subscribePosts };
  }

  return { subscribe, posts };
}
