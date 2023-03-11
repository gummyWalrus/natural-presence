<script lang="ts">
    export let skills: any[];
</script>

<ul class="ml-6">
    {#each skills as skill}
        <li>{ skill.description }</li>
    {/each}
</ul>

<style scoped>
    ul {
        list-style: initial;
        padding: 0;
    }
</style>