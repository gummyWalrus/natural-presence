import apiService from '$lib/services/api.service';
async function getExperience() {
	return await apiService.getExperience().then((data) => {
		return data;
	});
}

/** @type {import('./$types').LayoutLoad} */
export async function load({ params }: any) {
	return {
		formations: await getExperience()
	};
}
