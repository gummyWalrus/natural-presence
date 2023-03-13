<script lang="ts">
    export let categories: any;
</script>

<div class="hidden md:w-1/4 md:flex flex-col text-lg font-bold bg-metal rounded-lg p-3 h-full m-3">
    <div class="text-lg font-bold border-b border-b-slate-500 pb-3">Categories</div>
    {#each categories as category}
        <a href="/category/{category.id}" class="text-slate-300 hover:text-blue-300">
            <div class="flex items-center py-2 px-4 rounded-lg">
                <div class="">
                    {category.title}
                </div>
            </div>
        </a>
    {/each}
</div>

<style scoped>
    .category-menu {
        border-radius: 1rem;
    }
</style>