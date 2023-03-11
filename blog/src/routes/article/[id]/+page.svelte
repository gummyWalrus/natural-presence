<script lang="ts">
	import type IArticle from '$lib/types/article';
	import snarkdown from 'snarkdown';
	import Date from '$lib/Date.svelte';
	import Comment from '$lib/Comment.svelte';
	import apiService from '$lib/services/api.service';
	export let data;
	let voteState = 0;
	let article: IArticle = data.article;

	function downvote() {
		if (voteState === -1) {
			article.downvotes--;
			voteState = 0;
		} else {
			article.downvotes++;
			if (voteState === 1) {
				article.upvotes--;
			}
			voteState = -1;
		}
		refreshArticle();
	}

	function upvote() {
		if (voteState === 1) {
			article.upvotes--;
			voteState = 0;
		} else {
			article.upvotes++;
			if (voteState === -1) {
				article.downvotes--;
			}
			voteState = 1;
		}
		refreshArticle();
	}

	function refreshArticle() {
		apiService.putArticle(article.id, article);
	}
</script>

<div class="flex flex-col">
	<div class="text-3xl font-bold text-slate-300 row flex justify-between">
		<div>
			{article.title}
		</div>
		<div>
			<button
				on:click={() => {
					voteState = 1;
					upvote();
				}}
				class="bg-metal px-3 hover:bg-lime-500 rounded-full text-3xl"
			>
				<i class="fa-solid fa-circle-up" />
			</button>
			{article.upvotes}
			<button
				on:click={() => {
					voteState = -1;
					downvote();
				}}
			>
				<i class="fa-solid fa-circle-down" />
			</button>
			{article.downvotes}
		</div>
	</div>
	<Date date={article.date_updated} />
	<div class="text-sm text-slate-300">
		{@html snarkdown(article.body)}
	</div>
	<Comment articleId={article.id} />
</div>
