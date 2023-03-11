<script lang="ts">
	import type IProfileSection from "$lib/types/section";

    export let section : IProfileSection;
</script>


<div class="bg-metal rounded-md flex-col py-1 px-4">
    <div class="text-2xl font-bold py-4">{section.title}</div>
    {#each section.items as item}
        <div class="flex flex-row mt-4">
            <div class="image">
                <img src={`${import.meta.env.VITE_API_URL}/assets/${item.image}`} alt="logo" />
            </div>
            <div class="flex flex-col ml-5 mt-2">
                <div class="text-lg font-bold">{item.title}</div>
                <div class="text-sm">{item.subtitle}</div>
            </div>
        </div>
    {/each}
</div>

<style>
    .image {
        width: 64px;
    }
    .item-text {
        margin-top: 1rem;
    }
</style>