<script>
  import boardContract from "../store/boardContract";
  import { useEthers } from "./EthersProvider.svelte";
  import Button from "./Button.svelte";
  import TextInput from "./TextInput.svelte";
  import Post from "./Post.svelte";

  export let address;

  const provider = useEthers();
  const board = boardContract(address, provider);
  const posts = board.posts();
  $: name = $provider.lookupAddress(address);
  $: addr = $provider.resolveName(address);

  $: console.log($posts);

  let composingMessage = "";
  async function post() {
    try {
      const result = await $board.postText(composingMessage);
      const after = await result.wait();
      composingMessage = "";
    } catch (error) {
      console.error(error);
    }
  }
</script>

<div>
  <stack-l class="section" style="--space: var(--s0)">
    <h1>
      {#await name then name}
        {#if name}
          {name}
        {:else}
          <span class="unfocus">Untitled Board</span>
        {/if}
      {:catch}
        <span class="unfocus">ENS not supported</span>
      {/await}
    </h1>

    {#await addr then addr}
      <code class="address">{address}</code>
    {/await}

    <form class="control" on:submit|preventDefault={post}>
      <TextInput bind:value={composingMessage} placeholder="Write a message" />
      <Button>Post</Button>
    </form>
  </stack-l>

  <stack-l class="posts grow">
    {#each [...$posts].reverse() as event}
      <Post {event} />
    {/each}
  </stack-l>
</div>

<style>
  .section {
    background-color: #EEE;
    padding: var(--s1);
  }

  .unfocus {
    opacity: 0.7;
  }

  .container {
    flex-grow: 1;
    height: 100%;
    min-height: 0;
  }

  .address {
    opacity: 0.7;
    font-size: var(--s-1);
  }

  .control {
    display: flex;
    flex-direction: row;
    gap: var(--s0);
  }

  .posts {
    overflow-y: auto;
    padding: var(--s0);
  }
</style>
