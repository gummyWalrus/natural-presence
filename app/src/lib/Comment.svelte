<script lang="ts">
	import snarkdown from 'snarkdown';
	import api from './services/api.service';
	import type IComment from './types/comment';
	let comments: IComment[] = [];

	getComments().then((data) => {
		comments = data;
	});

	let showComment = false;
	async function getComments() {
		return await api.getComments();
	}
</script>

<div class="px-6 mt-1">
	<div class="flex row justify-between">
		<div class="text-xl">Commentaires</div>
		<button
			on:click={() => {
				showComment = !showComment;
			}}
			class="bg-metal px-3 hover:bg-lime-500 rounded-full text-3xl">+</button
		>
	</div>
	{#each comments as comment}
		<div class=" my-3 rounded-lg bg-metal shadow-md">
			<div class="pb-2 p-3">
				<span class="comment-name">{comment.name}</span>
			</div>
			<div class="p-3 pl-6 flex flex-col">
				{@html snarkdown(comment.body)}
				<div class="flex place-content-end">
					<div class="text-xs text-gray-400">
						{new Date(comment.created_at).toLocaleString()}
					</div>
				</div>
			</div>
		</div>
	{/each}
</div>
