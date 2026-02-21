"use strict";

$(function()
{
	$(".btn-donate").on("click", {detailsElement: $(".pn-details-container")}, (ev) =>
	{
		if(ev.data.detailsElement.attr("inert") === undefined)
		{
			// Closing
			ev.data.detailsElement.attr("inert", "inert");
			ev.data.detailsElement.attr("aria-hidden", "true");
			return;
		}

		// Openning
		ev.data.detailsElement.attr("inert", null);
		ev.data.detailsElement.attr("aria-hidden", "false");
	});

	const ANIM_COM_ELEM = $(".animated-comments");

	ANIM_COM_ELEM.on("animationiteration", {
		animatedCommentsElement: ANIM_COM_ELEM,
		maxOfTries: 5,
		lastCommentsList: [],
		commentsList: [
			"aaaaaaaaaaaaaaaa",
			"bbbbbbbbbbbbbbbb",
			"cccccccccccccccc",
			"dddddddddddddddd",
			"eeeeeeeeeeeeeeee",
			"ffffffffffffffff",
			"gggggggggggggggg",
			"hhhhhhhhhhhhhhhh",
			"iiiiiiiiiiiiiiii",
		],
	}, (ev) =>
	{
		let isValid = true;
		let newComment;

		for(let i = 0; i < ev.data.maxOfTries; i++)
		{
			newComment = ev.data.commentsList[ Math.floor( Math.random() * ev.data.commentsList.length ) ]

			for(const LAST_COMMENT of ev.data.lastCommentsList)
			{
				if(newComment === LAST_COMMENT)
				{
					isValid = false;
					break;
				}
			}

			if(!isValid)
			{
				isValid = true; // reset
				continue;
			}

			if(ev.data.lastCommentsList.length === ev.data.maxOfTries)
				ev.data.lastCommentsList.shift();

			ev.data.lastCommentsList.push( newComment );
			break;
		}

		// It the maximum of tries is achieved, the last
		// chosen message is used, and it is not added to
		// comments "cache".

		ev.data.animatedCommentsElement.text( newComment );
	});
});
