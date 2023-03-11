<script lang="ts">
    import { lang } from "./store/store";
    import { getTextDateDifference } from "./utils/date";
    export let date : Date;

    let currentLang = $lang === 'en' ? 'en-US' : 'fr-FR';
</script>

<div class="text-sm text-slate-300">
    {date.toLocaleTimeString(currentLang)}
    { getTextDateDifference(date, new Date()) }
</div>