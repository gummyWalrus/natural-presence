<script lang="ts">
	import { page } from '$app/stores';
	import type IProfile from '$lib/types/profile';
	export let profile : IProfile;
</script>

<div class="navbar w-full bg-gray-700 flex flex-row px-4 py-2 justify-between">
	<div class="navbar-brand">
		<a href="/" class="flex flex-row">
			<div class="round-image">
				<img src={`${import.meta.env.VITE_API_URL}/assets/${profile.logo}`} alt="logo" />
			</div>
			<div class="text-xl mt-4 ml-4">{profile.name}</div>
		</a>
	</div>
	<div class="flex flex-row justify-evenly text-lg">
		<a
			href="/"
			class={`text-center mt-2 border-y-slate-100 py-2`}
			class:border-b-2="{$page.url.pathname.endsWith('/')}"
		>
			Portofolio
		</a>
		<a
			href="/profile"
			class={`text-center ml-10 mt-2  border-y-slate-100 py-2`}
			class:border-b-2="{$page.url.pathname.endsWith('/')}"
		>
			Profile
		</a>
	</div>
	<!-- <LanguageButton /> -->
</div>

<style scoped>
	.navbar {
		position: fixed;
		top: 0;
		left: 0;
		color: white;
	}

	.icon {
		width: 2rem;
		height: 2rem;
		display: inline-block;
		vertical-align: middle;
	}
</style>
