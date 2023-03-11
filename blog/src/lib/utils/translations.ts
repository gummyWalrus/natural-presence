export interface ITranslation {
	today: any;
	yesterday: any;
	years_ago: (years: number) => any;
	months_ago: (months: number) => any;
	days_ago: (days: number) => any;
	hours_ago: (hours: number) => any;
	minutes_ago: (minutes: number) => any;
	seconds_ago: (seconds: number) => any;
	now: any;
}

export default {
	today: {
		en: 'Today',
		fr: "Aujourd'hui"
	},
	yesterday: {
		en: 'Yesterday',
		fr: 'Hier'
	},
	years_ago: (years: number): any => ({
		en: `${years.toFixed(0)} years ago`,
		fr: `Il y a ${years.toFixed(0)} ans`
	}),
	months_ago: (months: number): any => ({
		en: `${months.toFixed(0)} months ago`,
		fr: `Il y a ${months.toFixed(0)} mois`
	}),
	days_ago: (days: number): any => ({
		en: `${days.toFixed(0)} days ago`,
		fr: `Il y a ${days.toFixed(0)} jours`
	}),
	hours_ago: (hours: number): any => ({
		en: `${hours.toFixed(0)} hours ago`,
		fr: `Il y a ${hours.toFixed(0)} heures`
	}),
	minutes_ago: (minutes: number): any => ({
		en: `${minutes.toFixed(0)} minutes ago`,
		fr: `Il y a ${minutes.toFixed(0)} minutes`
	}),
	seconds_ago: (seconds: number): any => ({
		en: `${seconds.toFixed(0)} seconds ago`,
		fr: `Il y a ${seconds.toFixed(0)} secondes`
	}),
	now: {
		en: 'Now',
		fr: "A l'instant"
	}
};
