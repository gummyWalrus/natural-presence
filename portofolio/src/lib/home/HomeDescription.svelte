<script lang="ts">
	import snarkdown from 'snarkdown';
	import api from '$lib/services/api.service';
	let description = '';

	getProfile().then((data) => {
		description = data.description;
	});

	async function getProfile() {
		return await api.getProfile();
	}
</script>

<div class=" my-3 rounded-lg">
	{@html snarkdown(description)}
</div>
