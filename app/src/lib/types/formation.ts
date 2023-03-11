export interface ILifePeriod {
	id: Number;
	start: Date;
	end?: Date;
	name: String;
	current: Boolean;
	institution: String;
	image: any;
	skills?: any[];
	translations?: any[];
}

export const PeriodType = {
	formation: 1,
	experience: 2
};

export function newLifePeriod({
	id,
	start,
	end,
	name,
	current,
	institution,
	image,
	skills,
	translations
}: any): ILifePeriod {
	return {
		id,
		start: new Date(start),
		end: current ? undefined : new Date(end),
		name,
		current,
		institution,
		image,
		skills,
		...translations![0]
	};
}
