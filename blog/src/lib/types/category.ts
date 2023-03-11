import type IArticle from './article';

export default interface ICategory {
	id: number;
	title: string;
	articles?: IArticle[];
}

export function newCategory(data: any): ICategory {
	return {
		id: data.id,
		title: data.translations[0].title
	};
}
