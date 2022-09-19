<script>
  import EthersProvider from "./components/EthersProvider.svelte";
  import Board from "./components/Board.svelte";
</script>

<EthersProvider>
  <Board address="0xC7aCcea25C4bBd31a5084C26A4654B375392b5D2" />
</EthersProvider>

<style>
  :global(body) {
    height: 100%;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }
</style>
