<script lang="ts">
	import type IProject from '$lib/types/project';

	export let project: IProject;
	if (typeof project.tags == 'string') project.tags = JSON.parse(project.tags);
</script>

<div class="my-3 rounded-lg shadow-md bg-metal">
	<div class="pb-12 p-3 flex-col h-full relative">
		<div class="py-2">
			<div class="text-lg mb-1">{project.name}</div>
			<div class="text-md text-gray-400 mb-1">{project.title}</div>
		</div>
		{#if project.tags && project.tags.length > 0}
			<ul class="mb-3 flex flex-row">
				{#each project.tags as tag}
					<li
						class="rounded-2xl text-black text-sm bg-green-400 px-2 py-1 mx-1 transition ease duration-300 hover:text-metal"
					>
						<a href={tag.link}>
							<i class={tag.icon} />
							{tag.name}
						</a>
					</li>
				{/each}
			</ul>
		{/if}
		<div class="p-1 mb-3 flex flex-col">
			<div>{project.body}</div>
		</div>
		<div class="flex flex-row justify-evenly absolute bottom-1" style="width:100%">
			{#if project.languages && project.languages.length > 0}
				<ul class="flex flex-row mb-3 mt-1.5">
					{#each project.languages as language}
						<li>
							<a href={language.languages_id.link}>
								<img
									class="badge-img ml-2"
									src={import.meta.env.VITE_API_URL + '/assets/' + language.languages_id.logo}
									alt={language.languages_id.name}
								/>
							</a>
						</li>
					{/each}
				</ul>
			{/if}
			<ul class="flex flex-row">
				{#if project.github}
					<li>
						<a href={project.github}>
							<div
								class="flex flex-row text-md rounded-2xl border-green-400 border-2 text-green-400 transition ease duration-300 hover:bg-green-400 hover:text-metal px-3 py-2"
							>
								<i class="fa-brands fa-github mt-1" />
								<div class="ml-2">Github</div>
							</div>
						</a>
					</li>
				{/if}
			</ul>
		</div>
	</div>
</div>

<style scoped>
	.badge-img {
		max-width: 2rem;
		max-height: 2rem;
	}

	.icon {
		width: 1.5rem;
		height: 1.5rem;
		display: inline-block;
		vertical-align: middle;
	}
</style>
