<script lang="ts">
	import type { ILifePeriod } from "$lib/types/formation";

    export let formation: ILifePeriod;
</script>

<div class="flex-row flex mt-4">
    <div class="flex flex-row items-center">
        <i class="duo calendar_big large bg-slate-50"></i>
        <div class="text-lg py-4 ml-3">{ formation.start.getFullYear() }, { formation.current ? 'Now' : formation.end?.getFullYear() }</div>
    </div>
    <div class="flex flex-row items-center ml-10">
        <i class="duo rocket large bg-slate-50"></i>
        <div class="text-lg py-4 ml-3">{ formation.institution }</div>
    </div>
</div>