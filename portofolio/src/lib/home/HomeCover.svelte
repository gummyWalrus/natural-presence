<script lang="ts">
	import Description from '$lib/home/HomeDescription.svelte';
	import apiService from '$lib/services/api.service';
	import HomeName from './HomeName.svelte';
	import HomeLinks from './HomeLinks.svelte';
	import type IProfile from '$lib/types/profile';

	export let profile: IProfile;

	getProfile();

	async function getProfile() {
		profile = await apiService.getProfile();
	}
</script>

<div class="flex flex-col items-center">
	<div class="flex flex-row justify-center py-20">
		<div class="text-center">
			<HomeName {profile}/>
			<HomeLinks {profile} />
		</div>
	</div>
	<div class="flex flex-row text-lg justify-evenly text-black">
		<div class="bg-green-400 rounded px-4 py-2 transition ease duration-300 hover:text-metal">
			<i class="fa-solid fa-phone mr-2" />
			{profile.phone}
		</div>
		<div
			class="bg-green-400 rounded px-4 py-2 ml-4 hover:text-metal  transition ease duration-300 "
		>
			<i class="fa-solid fa-envelope mr-2" />
			{profile.email}
		</div>
	</div>
</div>

<style scoped>
	.rounded {
		border-radius: 2rem;
	}
</style>
