import apiService from '$lib/services/api.service';

async function getArticle(id: number) {
	return apiService.getArticle(id);
}

/** @type {import('./$types').LayoutLoad} */
export async function load({ params }: any) {
	return {
		article: await getArticle(parseInt(params.id))
	};
}
