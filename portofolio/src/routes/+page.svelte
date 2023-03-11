<script lang="ts">
	import Projects from '$lib/portofolio/Portofolio.svelte';
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
</section>

