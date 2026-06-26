"use strict";

window.addEventListener("DOMContentLoaded", () =>
{
	/* This hidden element will be used to store,
	 * temporarilly, the text that will be copied,
	 * before to try use the fallback clipboard
	 * API; this is done because it only can copy
	 * text from "input elements", like <textarea>. */
	const bridgeElem = document.createElement("input");
	bridgeElem.style.display = "none";
	document.body.appendChild(bridgeElem);

	class ClipboardAPIError extends Error
	{
		constructor(msg = "Impossible copy text. An internal error occur.", isMainAPI = true)
		{
			super(`${isMainAPI ? "Main" : "Fallback"} Clipboard API: ${msg}.`);
		}
	}

	const copyTextFallbackAPI = (text)
	{
		if(!(bridgeElem instanceof HTMLInputElement))
			throw new ClipboardAPIError("the \"bridge element\" was corrupted", false);

		try
		{
			bridgeElem.value = text;
			bridgeElem.focus();
			bridgeElem.select();
			bridgeElem.setSelectionRange(0, input.value.length);
		}
		catch(ex)
		{
			console.error(ex);
			throw new ClipboardAPIError("an error occur during manipulation of the \"bridge element\"", false);
		}

		if(!document.execCommand)
			throw new ClipboardAPIError("impossible found API", false);

		if(!document.execCommand("copy"))
			throw new ClipboardAPIError("impossible copy the text", false);
	};

	const copyTextMainAPI = (text) =>
	{
		if(!navigator.clipboard || !navigator.clipboard.writeText)
			return ClipboardAPIError("impossible found API");

		navigator.clipboard.writeText(text)
			.then(() =>
			{
				if(window.createNotifToast !== undefined)
					window.createNotifToast("ok", "Copied");
			})
			.catch((mainAPIError) =>
			{
				console.error(mainAPIError);

				try
				{
					copyTextFallbackAPI(text);

					if(window.createNotifToast !== undefined)
						window.createNotifToast("ok", "Copied");
				}
				catch(ex)
				{
					console.error(ex);

					if(window.createNotifToast !== undefined)
						window.createNotifToast("error", "Impossible to copy");
				}
			});
	};

	window.copyText = (text) =>
	{
		copyTextMainAPI(text);
	};
});

