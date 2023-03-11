<script lang="ts">
	import type IArticle from './types/article';
	import DDate from '$lib/Date.svelte';
	export let articles: IArticle[];
	const sortedArticles = articles.sort((a: IArticle, b: IArticle) => {
		return new Date(b.date_updated).getTime() - new Date(a.date_updated).getTime();
	});
</script>

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
