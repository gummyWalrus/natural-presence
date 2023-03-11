<script lang="ts">
	import type IProfile from '$lib/types/profile';
	export let profile: IProfile;
</script>

<div class="flex flex-row justify-center mx-6 text-4xl mt-2">
	<a href={profile.linkedin} class="px-4 py-2 transition ease duration-300 hover:text-green-400">
		<i class="fa-brands fa-linkedin" />
	</a>
	<a href={profile.github} class="px-4 py-2 ml-2 transition ease duration-300 hover:text-green-400">
		<i class="fa-brands fa-github" />
	</a>
	<a
		href={profile.stackoverflow}
		class="px-4 py-2 ml-2 transition ease duration-300 hover:text-green-400"
	>
		<i class="fa-brands fa-stack-overflow" />
	</a>
</div>

<style scoped>
	.round-button {
		border-radius: 2rem;
	}
</style>
