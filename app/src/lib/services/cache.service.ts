export default {
	get: (path: string, params: any) => {
		const data = path + JSON.stringify(params);
		const res = localStorage.getItem(btoa(data));
		return res != null ? res : '{}';
	},
	set: (path: string, params: any, res: any) => {
		const data = path + JSON.stringify(params);
		localStorage.setItem(btoa(data), JSON.stringify(res));
	},
	has: (path: any, params: any) => {
		const data = path + JSON.stringify(params);
		return localStorage.getItem(btoa(data)) !== null;
	}
};
