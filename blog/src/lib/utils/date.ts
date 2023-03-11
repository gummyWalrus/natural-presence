import translations from './translations';

export function getDateDiff(dateA: Date, dateB: Date): number {
	return Math.abs(dateA.getTime() - dateB.getTime());
}

export function getDateDiffInYears(dateA: Date, dateB: Date): number {
	return getDateDiff(dateA, dateB) / (1000 * 3600 * 24 * 365);
}

export function getDateDiffInMonths(dateA: Date, dateB: Date): number {
	return getDateDiff(dateA, dateB) / (1000 * 3600 * 24 * 30);
}

export function getDateDiffInDays(dateA: Date, dateB: Date): number {
	return getDateDiff(dateA, dateB) / (1000 * 3600 * 24);
}

export function getDateDiffInHours(dateA: Date, dateB: Date): number {
	return getDateDiff(dateA, dateB) / (1000 * 3600);
}

export function getDateDiffInMinutes(dateA: Date, dateB: Date): number {
	return getDateDiff(dateA, dateB) / (1000 * 60);
}

export function getDateDiffInSeconds(dateA: Date, dateB: Date): number {
	return getDateDiff(dateA, dateB) / 1000;
}

export function getTextDateDifference(dateA: Date, dateB: Date, langCode: string = 'en'): string {
	const diff = {
		years: getDateDiffInYears(dateA, dateB),
		months: getDateDiffInMonths(dateA, dateB),
		days: getDateDiffInDays(dateA, dateB),
		hours: getDateDiffInHours(dateA, dateB),
		minutes: getDateDiffInMinutes(dateA, dateB),
		seconds: getDateDiffInSeconds(dateA, dateB)
	};

	if (diff.years > 1) return translations.years_ago(getDateDiffInYears(dateA, dateB))[langCode];
	if (diff.months > 1) return translations.months_ago(getDateDiffInMonths(dateA, dateB))[langCode];
	if (diff.days > 1) return translations.days_ago(getDateDiffInDays(dateA, dateB))[langCode];
	if (diff.hours > 1) return translations.hours_ago(getDateDiffInHours(dateA, dateB))[langCode];
	if (diff.minutes > 1)
		return translations.minutes_ago(getDateDiffInMinutes(dateA, dateB))[langCode];
	if (diff.seconds > 1)
		return translations.seconds_ago(getDateDiffInSeconds(dateA, dateB))[langCode];
	return translations.now[langCode];
}
