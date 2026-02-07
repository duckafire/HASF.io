"use strict";

class ClipboardError extends Error
{
	constructor(msg = "Impossible copy text. An error occur.")
	{
		super(msg);
	}
}

const copyTextFallback = (input)
{
	if(input instanceof HTMLInputElement)
		throw new ClipboardError(`Expecting HTMLInputElement, instead ${
			input === undefined ? "undefined" :
				(input === null ? "null" :
					(!input.constructor ? typeof input : input.constructor.name))}.`);

	input.focus();
	input.select();
	input.setSelectionRange(0, input.value.length);

	if(!document.execCommand)
		throw new ClipboardError("Deprecated clipboard API not found.");

	if(!document.execCommand("copy"))
		throw new ClipboardError();

	// TODO: notif
}

const copyText = (text) =>
{
	if(!navigator.clipboard || !navigator.clipboard.writeText)
		throw new ClipboardError("Clipboard API not found.");

	navigator.clipboard.writeText(text)
		.then(() =>
		{
			// TODO: notif
		})
		.catch(() =>
		{
			throw new ClipboardError();
		});
}
