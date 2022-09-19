<script>
  export let value;
  export let placeholder;
</script>

<input type="text" bind:value {placeholder} />

<style>
  input {
    padding-inline: var(--s0);
    padding-block: var(--s-3);
    background: white;
    border-width: 1px;
    border-color: black;
    flex-grow: 1;
  }
</style>
