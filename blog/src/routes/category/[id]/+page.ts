import apiService from '$lib/services/api.service';
import { lang } from '$lib/store/store';

async function getCategory(id: number) {
	return apiService.getCategory(id);
}

/** @type {import('./$types').LayoutLoad} */
export async function load({ params }: any) {
	return {
		category: await getCategory(parseInt(params.id))
	};
}
