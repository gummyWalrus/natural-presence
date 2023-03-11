export default interface IArticle {
	id: number;
	title: string;
	body: string;
	date_updated: Date;
	tags: string[];
	categories: string[];
	comments: number[];
	downvotes: number;
	upvotes: number;
}

export function newArticle({
	id,
	translations,
	date_updated,
	tags,
	categories,
	comments,
	upvotes,
	downvotes
}: any): IArticle {
	return {
		id,
		title: translations[0].title,
		body: translations[0].body,
		date_updated: new Date(date_updated),
		tags,
		categories,
		comments,
		upvotes,
		downvotes
	};
}
