<script lang="ts">
	import type { ILifePeriod } from "$lib/types/formation";
	import FormationBottom from "./FormationBottom.svelte";
	import FormationSkills from "./FormationSkills.svelte";

    export let formation : ILifePeriod;
</script>


<div class="bg-metal rounded-md flex-row flex items-center py-1 px-4">
    <div class="image p-3">
        <img src="{import.meta.env.VITE_API_URL_CLIENT}/assets/{formation.image.id}" alt="logo" />
    </div>
    <div class="flex flex-col ml-3">
        <div class="text-2xl py-4">{formation.name}</div>
        {#if formation.skills && formation.skills.length}
            <FormationSkills skills={formation.skills} />
        {/if}
        <FormationBottom formation={formation} />
    </div>
</div>

<style scoped>
    .image {
        max-width: 50%;
    }
</style>