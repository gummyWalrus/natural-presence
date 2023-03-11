export interface ILanguage {
	id: Number;
	name: string;
	logo: string;
	link: string;
	languages_id: ILanguage;
}

export interface ITag {
	name: string;
	icon?: string;
	link?: string;
}

export default interface IProject {
	id: Number;
	name: string;
	title: string;
	body: string;
	github?: string;
	languages?: ILanguage[];
	tags?: ITag[];
	translations?: any;
}
