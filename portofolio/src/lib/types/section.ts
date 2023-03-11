interface IProfileSectionItem {
	id: Number;
	title: string;
	subtitle: string;
	image: string;
}

export default interface IProfileSection {
	id: Number;
	title: string;
	items: IProfileSectionItem[];
}
