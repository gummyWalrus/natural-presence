<script lang="ts">
    import LanguageButton from '$lib/navbar/LanguageButton.svelte';
    import type IProfile from '$lib/types/profile';
    import { lang } from '$lib/store/store';

    export let profile : IProfile;

    let isMenuOpen = false;

    var langCode = $lang;
    function toProfile()
    {
      window.location.href = '/profile';
    }

    function toFormation()
    {
      window.location.href = '/formation';
    }

    function toExperience()
    {
      window.location.href = '/experience';
    }

    function none()
    {
      return;
    }
</script>

<div class="">
  <div class="sidenav flex flex-col" id="mobileMenu">
    <div class="menu-item flex flex-nowrap">
        <div class="menu-link">
          <div class="round-image">
            <img src={`${import.meta.env.VITE_API_URL}/assets/${profile.logo}`} alt="logo" />
          </div>
        </div>
      <div class="text-xl whitespace-nowrap mt-2 ml-4">{profile.name}</div>
    </div>
    <div class="menu-item mt-5" on:click={toProfile} on:keypress={none}>
      <div class="menu-link text-white text-4xl">
        <i class="duo leave xlarge bg-slate-50"></i>
      </div>
      <div class="text-xl whitespace-nowrap mt-2 ml-4">Profile</div>
    </div>
    <div class="menu-item mt-5" on:click={toFormation} on:keypress={none}>
      <div class="menu-link text-white text-4xl">
        <i class="duo graduation_cap xlarge bg-slate-50"></i>
      </div>
      <div class="text-xl whitespace-nowrap mt-2 ml-4">Formation</div>
    </div>
    <div class="menu-item mt-5" on:click={toExperience} on:keypress={none}>
      <div class="menu-link text-white text-4xl">
        <i class="duo rocket xlarge bg-slate-50"></i>
      </div>
      <div class="text-xl whitespace-nowrap mt-2 ml-4">Experience</div>
    </div>
    <div class="menu-item">
      <div class="menu-link items-center ml-2">
        <LanguageButton />
      </div>
      <div class="text-xl whitespace-nowrap mt-2 ml-4">{ langCode === "fr" ? "Français" : "English" }</div>
    </div>
  </div>
</div>

<style scoped>

.menu-item {
  white-space: nowrap;
  align-items: center;
  justify-content: start;
  display: flex;
}

.menu-link {
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
}

.sidenav {
    z-index: 1;
    height: 64px;
    overflow-x: hidden;
    color: rgba(0,0,0, 0.8);
    /* background-color: rgb(0, 0, 0, 0.97); */
    transition: width 0.3s, color .8s ease-in-out;
    position: fixed;
    bottom: 0;
    width: 100%;
    /* background: linear-gradient(180deg, #374151 45%, #4ADE80 100%);  */

  }

.menu-item:last-child {
  position: absolute;
  bottom: 1rem;
  left: 0.5rem;
}

@media screen and (min-width: theme(screens.md)) {
  .sidenav {
    padding: 0.5rem;
    padding-top: 1rem;
    z-index: 1;
    width: 64px;
    overflow-x: hidden;
    color: black;
    background-color: rgb(0, 0, 0, 0.97);
    transition: width 0.3s, color .8s ease-in-out;
    position: fixed;
    height: 100%;
  } 
  .sidenav:hover {
    width: 250px;
    color: white;
  }

}



.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

.sidenav a:hover {
  color: #f1f1f1;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>