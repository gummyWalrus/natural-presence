<script lang="ts">
	import "../app.css";
  import "../icons.css";

	export let data : any;

  
</script>

<svelte:head>
  <title>Home</title>
  <meta name="description" content="CV" />
</svelte:head>

<div class="app">
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
</style>