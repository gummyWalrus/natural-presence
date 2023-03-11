<script lang="ts">
	import Project from '$lib/home/Project.svelte';
	import type IProject from './types/project';
	export let projects: IProject[] = [];
</script>

<p class="text-xl pl-6 mt-4">Projects</p>
<div class="px-6 grid grid-cols gap-3 xs:grid-cols-1">
	{#each projects as project}
		<Project {project} />
	{/each}
</div>

<style scoped>
</style>
