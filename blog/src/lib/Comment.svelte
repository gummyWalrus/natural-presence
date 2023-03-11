<script lang="ts">
	import snarkdown from 'snarkdown';
	import api from './services/api.service';
	import type IComment from './types/comment';

	export let articleId: number;

	let comments: IComment[] = [];
	let showComment = false;

	let comment = {
		name: '',
		body: ''
	};
	getComments().then((data) => {
		comments = data.filter((comment) => comment.article === articleId);
		console.log(comments);
	});

	async function getComments() {
		return await api.getComments();
	}

	async function sendComment() {
		if (!comment.name || !comment.body) return;
		const newComment = await api.postComment({ ...comment, ...{ article: articleId } });
		comments = [newComment, ...comments];
		comment = {
			name: '',
			body: ''
		};
	}
</script>

<div class="px-6 mt-1">
	<div class="flex row justify-between">
		<div class="text-xl">Commentaires</div>
		<button
			on:click={() => (showComment = !showComment)}
			class="bg-metal px-3 hover:bg-green-500 rounded-full text-3xl">+</button
		>
	</div>
	{#if showComment}
		<div class="my-3 rounded-lg bg-metal shadow-md">
			<div class="pb-2 p-3 pl-6">
				<input
					bind:value={comment.name}
					class="bg-metal rounded-lg text-white"
					placeholder="Votre nom"
				/>
			</div>
			<div class="p-3 pl-6 flex flex-col">
				<textarea
					bind:value={comment.body}
					class="bg-metal rounded-lg text-white w-full h-16"
					placeholder="Votre commentaire"
				/>
				<div class="flex place-content-end">
					<button
						on:click={sendComment}
						class="flex flex-row text-md rounded-2xl border-green-400 border-2 text-green-400 transition ease duration-300 hover:bg-green-400 hover:text-metal px-3 py-2 mt-2"
					>
						<i class="fas fa-paper-plane mr-2 mt-1" /> Envoyer
					</button>
				</div>
			</div>
		</div>
	{/if}
	{#each comments as comment}
		<div class=" my-3 rounded-lg bg-metal shadow-md">
			<div class="pb-2 p-3">
				<span class="comment-name">{comment.name}</span>
			</div>
			<div class="p-3 pl-6 flex flex-col">
				{comment.body}
				<div class="flex place-content-end">
					<div class="text-xs text-gray-400">
						{new Date(comment.created_at).toLocaleString()}
					</div>
				</div>
			</div>
		</div>
	{/each}
</div>
