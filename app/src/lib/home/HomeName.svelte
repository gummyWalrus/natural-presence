<script lang="ts">
	import type IProfile from '$lib/types/profile';
	export let profile : IProfile;
</script>

<div class="">
	<h1 class="text-5xl mb-3">{profile.name}</h1>
	<h2 class="text-3xl">{profile.poste}</h2>
</div>

<style scoped>
</style>
