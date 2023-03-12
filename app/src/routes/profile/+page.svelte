<script lang="ts">
	import type IProfileSection from "$lib/types/section";
	import Section from "./components/Section.svelte";
	import type IProfile from "$lib/types/profile";


    export let data;

    const sections : IProfileSection[] = data.profile.sections;
    const profile : IProfile = data.profile;
</script>
<svelte:head>
  <title>Profile</title>
  <meta name="description" content="CV" />
</svelte:head>

<div class="grid md:grid-cols-2 gap-4 mx-3 pt-10">
    <div class="flex profile py-4 bg-metal flex-col items-center px-5">
      <div class="img-thumbnail relative">
        <img src={`${import.meta.env.VITE_API_URL_CLIENT}/assets/${profile.logo}`} alt="logo" />
      </div>
      <div>
        <div class="text-2xl">
        {profile.name}
        </div>
        <div class="text-sm mt-4">
        {profile.description}
        </div>
      </div>
      <div class="flex flex-row mt-6 border-spacing-1 justify-between w-full">
        <i class="fa-solid fa-envelope text-2xl"></i>
        <div class="text-lg ml-2">
        {profile.email}
        </div>
      </div>
      <div class="flex flex-row mt-6 border-spacing-1 w-full justify-between">
        <i class="fa-solid fa-phone text-2xl"></i>
        <div class="text-lg ml-2">
        {profile.phone}
        </div>
      </div>
    </div>
    {#each sections as section}
    <Section section={section} />
    {/each}
</div>

<style scoped>
  .profile {
    text-align: center;
  }
  .profile .img-thumbnail {
    width: 20%;
    height: auto;
    border-radius: 10px;
    overflow: hidden;
    border-color: white;
    top: -50px;
  }
  .bg-metal {
    border-radius: 10px;
  }
</style>