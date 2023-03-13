<script lang="ts">
	import type IArticle from './types/article';
	import DDate from '$lib/Date.svelte';
	import { page } from '$app/stores'

	export let articles: IArticle[];
	var sortedArticles = articles.sort((a: IArticle, b: IArticle) => {
		return new Date(b.date_updated).getTime() - new Date(a.date_updated).getTime();
	})
	if ($page.url.searchParams.get('s')) {
		sortedArticles = sortedArticles.filter((el) => el.title.includes($page.url.searchParams.get('s')));
	}
	console.log('sus')
	function filterArticles() {
		console.log('sus')
		const value = document.getElementById('searchBar')!.value;
		window.location.search = '?s=' + value
	}

</script>


<div class="m-3">
	<div class="mt-3 mb-3 border-slate-500 border rounded searchZone">
		<input id="searchBar" />
		<div id="searchIcon" class="border-left-slate-500 hover:text-green-400" on:click={filterArticles}>
			<i class="fa fa-search mt-2" style="margin-left: 100%;"></i>
		</div>
	</div>
	<div
		class="w-full md:w-3/4 grid grids-cols-2 md:grid-cols-3 border border-slate-500 p-3 rounded-lg"
	>
		{#each sortedArticles as article}
			<div class="flex flex-col">
				<a href="/article/{article.id}" class="text-lg text-blue-300">
					{article.title}
				</a>
				<DDate date={article.date_updated} />
			</div>
		{/each}
	</div>
</div>

<style scoped>
	.searchZone {
		display: flex;
	}
	#searchBar {
    background: #374151;
	height: 2rem;
	width: 80%;
	}
</style>
