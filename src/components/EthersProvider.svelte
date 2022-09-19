<script context="module">
  import { ethers } from "ethers";
  import { writable } from "svelte/store";
  import { getContext } from "svelte";
  const EthersContext = Symbol("Ethers");

  function makeProvider() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);

    const { subscribe, set } = writable(null);

    async function connect() {
      try {
        await provider.send("eth_requestAccounts", []);
        set(provider);
      } catch {
        set(null);
      }
    }

    window.ethereum.on("chainChanged", () => window.location.reload());
    window.ethereum.on("accountsChanged", (accounts) => set(accounts?.length ? provider : null));
    window.ethereum.on("disconnect", () => set(null));

    return { subscribe, connect };
  };

  export function useEthers() {
    return getContext(EthersContext);
  }
</script>

<script>
  import { setContext } from "svelte";
  import Button from "./Button.svelte";

  const provider = makeProvider();
  const initial = provider.connect();

  setContext(EthersContext, provider);
</script>

{#if window.ethereum}
  {#await initial then _}
    {#if $provider}
      <slot />
    {:else}
      <div class="gate">
        <stack-l>
          <p>You must first connect your account.</p>

          <Button on:click={provider.connect}>Connect</Button>
        </stack-l>
      </div>
    {/if}
  {/await}
{:else}
  <div class="gate">
    You must use a Web3 enabled browser.
  </div>
{/if}

<style>
  .gate {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    flex-grow: 1;
  }
</style>
