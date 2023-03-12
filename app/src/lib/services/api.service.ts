import axios from 'axios';
import cacheService from './cache.service';
import { lang } from '$lib/store/store';
// import type LANG_TYPE from '$lib/types/lang';

import type IComment from '$lib/types/comment';
import type IProfile from '$lib/types/profile';
import type IProject from '$lib/types/project';
import { PeriodType, type ILifePeriod } from '$lib/types/formation';
import { newLifePeriod } from '$lib/types/formation';


var URL = import.meta.env.VITE_API_URL;

if (!process) {
	URL = import.meta.env.VITE_API_URL_CLIENT;
}


let langCode: string;

lang.subscribe((value) => {
	langCode = value;
});

export default {
	get: async function get(path: string, params: any, cache: boolean = true) {
		if (cache && cacheService.has(path, params)) return JSON.parse(cacheService.get(path, params));
		let res = {};
		if (params) {
			res = await axios.get(URL + path, { params: params });
		} else {
			res = await axios.get(URL + path);
		}
		if (cache) cacheService.set(path, params, res);
		return res;
	},

	post: async function post(path: string, data: any) {
		return await axios.post(URL + path, data);
	},
	getProfile: async function getProfile(): Promise<IProfile> {
		const data = (
			await this.get(
				'/items/profile',
				{
					'deep[translations][_filter][lang_code][_eq]': langCode,
					'deep[sections][items][translations][_filter][lang_code][_eq]': langCode,
					fields: '*,sections.*,sections.items.*,sections.items.translations.*,translations.*'
				},
				false
			)
		).data.data[0];
		let formatProfile = {
			...data,
			...data.translations[0],
			sections: data.sections.map((section: any) => {
				return {
					...section,
					items: section.items.map((item: any) => {
						return { ...item, ...item.translations[0] };
					})
				};
			})
		};
		return formatProfile;
	},
	getComments: async function getComments(): Promise<IComment[]> {
		return (await this.get('/items/comments', undefined, false)).data.data;
	},
	getProjects: async function getProjects() {
		const projects = (
			await this.get(
				'/items/projects',
				{
					'deep[translations][_filter][lang_code][_eq]': langCode,
					fields: '*.*,languages.languages_id.*'
				},
				false
			)
		).data.data;
		return projects.map((project: IProject) => ({ ...project, ...project.translations[0] }));
	},

	getFormations: async function getFormations(): Promise<ILifePeriod[]> {
		const formations = (
			await this.get(
				'/items/formations',
				{
					filter: {
						type: {
							_eq: PeriodType.formation
						}
					},
					'deep[translations][_filter][lang_code][_eq]': langCode,
					fields: '*.*,skills.*'
				},
				false
			)
		).data.data;
		return formations.map(newLifePeriod);
	},

	getExperience: async function getExperience(): Promise<ILifePeriod[]> {
		const formations = (
			await this.get(
				'/items/formations',
				{
					filter: {
						type: {
							_eq: PeriodType.experience
						}
					},
					'deep[translations][_filter][lang_code][_eq]': langCode,
					fields: '*.*,skills.*'
				},
				false
			)
		).data.data;
		return formations.map(newLifePeriod);
	},

	async postComment(comment: any) {
		return (await this.post('/items/comments', comment)).data.data;
	}
};
