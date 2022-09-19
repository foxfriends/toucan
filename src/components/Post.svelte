<script>
  import TextPost from "./TextPost.svelte";

  export let event;
</script>

{#if event.event === "PostedText"}
  <TextPost {event} />
{/if}
