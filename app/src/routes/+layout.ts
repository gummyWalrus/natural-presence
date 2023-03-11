import apiService from '$lib/services/api.service';
import { lang } from '$lib/store/store';

async function getProfile() {
	return await apiService.getProfile().then((data) => {
		return data;
	});
}

async function getProjects() {
	return await apiService.getProjects().then((data) => {
		return data;
	});
}

/** @type {import('./$types').LayoutLoad} */
export async function load({ url }: any) {
	if (url.searchParams.get('lang')) {
		lang.update((val: string) => url.searchParams.get('lang'));
	}
	return {
		profile: await getProfile(),
		projects: await getProjects()
	};
}
