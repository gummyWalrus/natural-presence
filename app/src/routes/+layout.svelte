<script lang="ts">
	import MobileMenu from '$lib/mobile/MobileMenu.svelte';
	import Sidebar from '$lib/mobile/Sidebar.svelte';
	import "../app.css";
  import "../icons.css";

	export let data : any;

  
</script>

<svelte:head>
  <title>Home</title>
  <meta name="description" content="CV" />
</svelte:head>

<div class="app">
  <Sidebar />
	<MobileMenu profile={data.profile} />
	<main>
		<slot />
	</main>

	<!-- <footer>
		<p>Created with <a href="https://svelte.dev">Svelte</a></p>
	</footer> -->
</div>

<style>
	@font-face {
        font-family: font;
        src: url("/fonts/static/Raleway-Regular.ttf");
        font-weight: 400;
      }
      @font-face {
        font-family: font;
        src: url("/fonts/static/Raleway-Bold.ttf");
        font-weight: 700;
      }
      @font-face {
        font-family: font;
        src: url("/fonts/static/Raleway-Italic.ttf");
        font-weight: 400;
        font-style: italic;
      }
      @font-face {
        font-family: font;
        src: url("fonts/static/Raleway-BoldItalic.ttf");
        font-weight: 700;
        font-style: italic;
      }
      @font-face {
        font-family: font;
        src: url("/fonts/static/Raleway-Light.ttf");
        font-weight: 300;
      }
      @media screen and (min-width: 768px) {
        main {
            margin-left: 64px;
        }
      }
</style>