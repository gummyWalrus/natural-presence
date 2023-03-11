import apiService from '$lib/services/api.service';

async function getProjects() {
	return await apiService.getProjects().then((data) => {
		return data;
	});
}

/** @type {import('./$types').LayoutLoad} */
export async function load({ params }: any) {
	console.log('params', params);
	const allProjects = await getProjects();
	const filter = allProjects.filter((project: any) => {
		console.log('project.id', project.id);
		return project.id === Number(params.id);
	});
	const project = filter[0];
	console.log('project', project);
	return {
		project: project
	};
}
