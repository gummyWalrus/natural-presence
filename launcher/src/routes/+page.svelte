<script>
  let domain = "";
  let loading = false;
  let done = false;
  function triggerJenkins() {
    loading = true;
    fetch(
      "http://localhost:8080/job/Deploy%20Natural%20Presence/buildWithParameters?DOMAIN=" +
        domain,
      {
        method: "POST",
        headers: {
          Authorization:
            "Basic " + btoa("admin:11e070533976b089e4871645729db23153"),
        },
      }
    )
      .then((response) => {
        loading = false;
        done = true;
        if (response.ok) {
          console.log("Success:", response);
        } else {
          console.error("Error:", response);
        }
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }
</script>

<div class="text-center">
  <h1>Bienvenue sur l'instance de déploiement Natural Presence</h1>

  <div class="mt-4">
    Ici vous pourrez déployer votre application en quelques clics.
  </div>

  <div class="mt-4">
    C'est tout simple, il vous suffit de réserver un nom de domaine chez un
    organisme compétent (<a href="https://ovh.com">OVH</a>,
    <a href="https://gandi.net">Gandi</a>, etc.) d'enregistrer un pointage DNS
    vers l'IP de nos serveurs <u>35.241.191.163</u> et de le renseigner
    ci-dessous.
    <br /><br />

    On s'occupe du reste !
  </div>

  <input
    type="text"
    class="mt-4"
    placeholder="Choisissez un nom de domaine"
    bind:value={domain}
  />
  <button class="mt-4" on:click={triggerJenkins}>Déployer</button>

  {#if loading}
    <div class="mt-4">Chargement...</div>
  {/if}
  {#if done}
    <div class="mt-4">
      Déploiement lancé ! D'ici quelques minutes, vous aurez accès à votre
      infrastructure !
    </div>
    <div class="mt-4">
      Sur <a href="http://{domain}">{domain}</a> vous aurez accès à votre site web
      portofolio.
    </div>
    <div class="mt-4">
      Sur le sous-domaine blog. <a href="http://blog.{domain}">blog.{domain}</a>
      vous aurez accès à votre blog personnel pour poster des articles.
    </div>
    <div class="mt-4">
      Sur le sous-domaine <a href="http://cv.{domain}">cv.{domain}</a> vous aurez
      accès à votre CV pour montrer vos compétences.
    </div>
    <div class="mt-4">
      Sur le sous-domaine <a href="http://backoffice.{domain}"
        >backoffice.{domain}</a
      > vous aurez accès à votre administration pour gérer vos contenus (des exemples
      y sont déja présent).
    </div>
  {/if}
</div>

<style>
  input {
    width: 400px;
    height: 40px;
    font-size: 20px;
    padding: 0 10px;
  }
  button {
    width: 400px;
    height: 40px;
    font-size: 20px;
    padding: 0 10px;
  }
  u {
    text-decoration: underline;
    color: blue;
  }
  .mt-4 {
    margin-top: 20px;
  }
</style>
