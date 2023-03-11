<script lang="ts">
	import type IProject from "$lib/types/project";


    export let data : any;
    const project: IProject = data.project;
    console.log("TAGS", project.tags);
</script>

<div class="m-5">
    <div class="text-2xl font-bold mb-3">
        <h1>{project.name}</h1>
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

    <div class="text-lg">
        <p>{project.body}</p>
    </div>
    <div>
    </div>
</div>