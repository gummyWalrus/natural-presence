import axios from 'axios';
import cacheService from './cache.service';
import { lang } from '$lib/store/store';

import type IProfile from '$lib/types/profile';
import type IArticle from '$lib/types/article';
import type ICategory from '$lib/types/category';
import { newArticle } from '$lib/types/article';
import type IComment from '$lib/types/comment';

var URL = import.meta.env.VITE_API_URL;

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
	put: async function put(path: string, data: any) {
		return await axios.patch(URL + path, data);
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
	getCategories: async function getCategories(): Promise<ICategory> {
		const data = (
			await this.get(
				'/items/categories',
				{
					'deep[translations][_filter][lang_code][_eq]': langCode,
					fields: '*,translations.*'
				},
				false
			)
		).data.data;
		let formatCategories = data.map((category: any) => {
			const newTitle = category.translations[0].title;
			category.translations = undefined;
			return { ...category, title: newTitle };
		});
		return formatCategories;
	},

	getCategory: async function getCategory(id: number): Promise<ICategory> {
		const data = (
			await this.get(
				'/items/categories/' + id,
				{
					'deep[translations][_filter][lang_code][_eq]': langCode,
					'deep[articles][translations][_filter][lang_code][_eq]': langCode,
					fields: '*,articles.*,articles.translations.*,translations.*'
				},
				false
			)
		).data.data;
		let articles = await this.getArticles();
		articles = articles.filter((article: any) => article.categories.includes(id));
		let formatCategory = {
			...data,
			...data.translations[0],
			articles: articles.map((article: any) => {
				return article;
			})
		};
		return formatCategory;
	},

	getArticles: async function getArticles(): Promise<IArticle[]> {
		const data = (
			await this.get(
				'/items/articles',
				{
					'deep[translations][_filter][lang_code][_eq]': langCode,
					fields: '*,translations.*'
				},
				false
			)
		).data.data;
		let formatArticles: IArticle[] = data.map(newArticle);
		return formatArticles;
	},

	getArticle: async function getArticle(id: number): Promise<IArticle> {
		const data = (
			await this.get(
				'/items/articles/' + id,
				{
					'deep[translations][_filter][lang_code][_eq]': langCode,
					fields: '*,translations.*'
				},
				false
			)
		).data.data;
		let formatArticle: IArticle = newArticle(data);
		return formatArticle;
	},
	async postComment(comment: any) {
		console.log('postComment', comment);
		return (await this.post('/items/comments', comment)).data.data;
	},
	getComments: async function getComments(): Promise<IComment[]> {
		return (await this.get('/items/comments', undefined, false)).data.data;
	},
	putArticle: async function putArticle(id: number, article: IArticle) {
		return await this.put('/items/articles/' + id, article);
	}
};
