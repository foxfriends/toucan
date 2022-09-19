<button on:click>
  <slot />
</button>

<style>
  button {
    padding-inline: var(--s0);
    padding-block: var(--s-3);
    background: white;
    border-width: 1px;
    border-color: black;
    font-weight: 600;
    text-transform: uppercase;
  }
</style>
