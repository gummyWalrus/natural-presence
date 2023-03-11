<script lang="ts">
	import Categories from "$lib/Categories.svelte";
	import LatestArticles from "$lib/LatestArticles.svelte";
	export let data : any;
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="CV" />
</svelte:head>

<section class="flex flex-row">
	<Categories categories={data.categories} />
	<LatestArticles articles={data.articles} />
</section>

