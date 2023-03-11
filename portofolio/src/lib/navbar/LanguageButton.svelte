<script lang="ts">
	import { lang } from "$lib/store/store";
	let lang_code : string;

	function toggleLanguage() {
		console.log('toggle language', lang_code)
		if (lang_code === 'en') lang.update((val : string) => 'fr');
		else lang.update((val : string) => 'en');

		window.location.reload();
	}

	lang.subscribe((value : string) => {
		lang_code = value;
	});
</script>

<div
	on:click={toggleLanguage}
	class="lang-image flex"
	on:keyup|preventDefault
	on:keydown|preventDefault
	on:keypress|preventDefault
>
	{#if lang_code === 'en'}
		<img src="img/usa.png" alt="USA" />
	{:else}
		<img src="img/fr.svg" alt="FR" />
	{/if}
</div>
<style scoped>
	.lang-image {
		margin-top: 16px;
		border-radius: 50%;
		overflow: hidden;
		height: 32px;
		width: 32px;
	}
</style>
