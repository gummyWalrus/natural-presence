import apiService from '$lib/services/api.service';
import { lang } from '$lib/store/store';

async function getCategories() {
	return apiService.getCategories();
}

async function getArticles() {
	return apiService.getArticles();
}

/** @type {import('./$types').LayoutLoad} */
export async function load({ url }: any) {
	if (url.searchParams.get('lang')) {
		lang.update((val: string) => url.searchParams.get('lang'));
	}
	return {
		categories: await getCategories(),
		articles: await getArticles()
	};
}
