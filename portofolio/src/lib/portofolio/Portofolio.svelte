<script lang="ts">
	import type IProject from "$lib/types/project";


    export let projects : IProject[];
</script>

<div class="portofolio grid grid-cols-1 md:grid-cols-2 gap-3 mt-4">
    {#each projects as project}
        <div class="flex flex-col" style="background-image: url('{ import.meta.env.VITE_API_URL }/assets/{ project.background.id }');">
            <a href="/project/{project.id}">
                <div class="wrapper">
                    <div class="text-2xl font-bold m-3">
                        <h2>{project.name}</h2>
                    </div>
                    {#if project.languages && project.languages.length > 0}
                        <ul class="flex flex-row mb-3 mt-1.5 languages">
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
                </div>
            </a>
        </div>
    {/each}
</div>

<style scoped>
.portofolio > div {
    overflow: hidden;
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    height: 20rem;
    display: flex;
    color: white;
    box-shadow: 0rem;
    border-radius: 1rem;
    transition: box-shadow 0.2s ease;
}

.portofolio > div:hover {
    box-shadow: 0px 0px 5px white;
}

div.wrapper {
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    height: 100%;
    width: 100%;
    background: linear-gradient(0deg, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0) 100%);
    transition: background 0.5s ease;
}

.portofolio > div > a {
    width: 100%;
    height: 100%;
}

div.wrapper {
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 100%;
    background: linear-gradient(0deg, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0.1) 100%);
}


div.wrapper > ul.languages {
    transform: translateY(1000%);
    transition: transform 0.2s ease;
}

div.wrapper > ul.languages {
    transform: translateY(0%);
}

ul.languages {
    list-style: none;
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
}

ul.languages > li {
    width: 4rem;
}

</style>