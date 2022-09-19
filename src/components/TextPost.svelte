<script>
  import { useEthers } from "./EthersProvider.svelte";
  import truncateAddress from "../util/truncateAddress";

  export let event;

  const provider = useEthers();

  $: [id, author, content] = event.args;
  $: block = $provider.getBlock(event.blockNumber);
  $: name = $provider.lookupAddress(author);
  $: addr = $provider.resolveName(author);
</script>

<stack-l class="post">
  <div class="byline">
    {#await name then name}
      {#if name}
        <div class="author">{name}</div>
        {#await addr then addr}
          <div class="address">
            (<code>{truncateAddress(addr)}</code>)
          </div>
        {:catch}
        {/await}
      {:else}
        {#await addr then addr}
          <div class="author">
            <code>{truncateAddress(addr)}</code>
          </div>
        {/await}
      {/if}
    {:catch}
      {#await addr then addr}
        <div class="author">
          <code>{truncateAddress(addr)}</code>
        </div>
      {/await}
    {/await}

    {#await block then block}
      <div class="date">
        {new Date(block.timestamp * 1000).toLocaleString()}
      </div>
    {/await}
  </div>

  <p>
    {content}
  </p>

  <details>
    <summary>Raw</summary>
    <code><pre>{JSON.stringify(event, null, 2)}</pre></code>
  </details>
</stack-l>

<style>
  .post {
    background: #EEE;
    padding: var(--s1);
  }

  .byline {
    display: flex;
    gap: var(--s0);
    align-items: center;
    padding-block-end: var(--s0);
    border-block-end-width: 1px;
  }

  .author {
    font-weight: 600;
  }

  .address {
    font-size: var(--s-1);
    opacity: 0.6;
  }

  .date {
    margin-inline-start: auto;
    font-size: var(--s-1);
    opacity: 0.6;
  }
</style>
