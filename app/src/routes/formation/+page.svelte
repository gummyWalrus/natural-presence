<script lang="ts">
	import Formation from "./components/Formation.svelte";


    export let data;
    const formations = data.formations;
</script>
<svelte:head>
  <title>Formation</title>
  <meta name="description" content="CV" />
</svelte:head>

<div class="flex flex-col">
  {#each formations as formation}
    <Formation formation={formation} />
  {/each}
</div>

<style scoped>
</style>