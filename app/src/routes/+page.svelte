<script lang="ts">
	import Comments from '$lib/Comment.svelte';
	import Projects from '$lib/Projects.svelte';
	import HomeCover from '$lib/home/HomeCover.svelte';
	
	export let data : any;
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="CV" />
</svelte:head>

<section>
	<HomeCover profile={data.profile} />
	<Projects projects={data.projects}/>
	<Comments />
</section>

