import apiService from '$lib/services/api.service';
async function getFormations() {
	return await apiService.getFormations().then((data) => {
		return data;
	});
}

/** @type {import('./$types').LayoutLoad} */
export async function load({ params }: any) {
	return {
		formations: await getFormations()
	};
}
