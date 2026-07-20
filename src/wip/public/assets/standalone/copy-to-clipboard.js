"use strict";

/**
 * ClipboardAPIError is the exception thrown by
 * functions declared here.
 *
 * copyTextToClipboard uses modern Clipboard API
 * (navigator.clipboard).
 *
 * copyTextFromInputElementToClipboard uses modern
 * Clipboard API (as main) and Legacy Clipboard API
 * (as fallback).
 */

class ClipboardAPIError extends Error
{
	/**
	 * @param {string} msg
	 */
	constructor(msg)
	{
		super(msg);
	}
}

/**
 * @param {!string}   text
 * @param {?(()=>void)} success
 * @param {?(()=>void)} failure
 * @throw {Error} Invalid arguments type or Clipboard API is unavailable.
 */
const copyTextToClipboard = (text, success = null, failure = null) => {
	if(typeof text !== "string")
		throw new ClipboardAPIError(`Expecting string, instead of ${typeof text}.`);

	if(typeof success !== "function" && success !== null && success != undefined)
		throw new ClipboardAPIError(`Expecting function, null, or undefined, instead of ${typeof success}.`);

	if(typeof failure !== "function" && failure !== null && failure != undefined)
		throw new ClipboardAPIError(`Expecting function, null, or undefined, instead of ${typeof failure}.`);

	if(!navigator.clipboard || !navigator.clipboard.writeText)
		throw new ClipboardAPIError("Impossible copy text; Clipboard API not found.");

	navigator
		.clipboard
		.writeText(text)
		.then(success)
		.catch(failure);
};

/**
 * @param {!(string | HTMLInputElement)} text
 * @param {?(()=>void)}                    success
 * @param {?(()=>void)}                    failure
 * @throw {Error} Invalid arguments type or Clipboard API is unavailable.
 */
const copyTextFromInputElementToClipboard = (input, success = null, failure = null) =>
{
	if((typeof input !== "string" && !(input instanceof HTMLInputElement))
	{
		/** @type {string} */
		let inputType = typeof input;

		if(inputType === "object")
		{
			if(inputType === null)
			{
				inputType = "null"

			}
			else if inputType.constructor !== undefined
			{
				if(inputType.constructor.name !== undefined)
					inputType = inputType.constructor.name;

				else
					inputType = "\"unknown\"";
			}
		}

		throw new ClipboardAPIError(`Expecting string or instance of HTMLInputElement, instead of ${inputType}.`);
	}

	if(typeof success !== "function" && success !== null && success != undefined)
		throw new ClipboardAPIError(`Expecting function, null, or undefined, instead of ${typeof success}.`);

	if(typeof failure !== "function" && failure !== null && failure != undefined)
		throw new ClipboardAPIError(`Expecting function, null, or undefined, instead of ${typeof failure}.`);

	/** @const {?string} */
	let text = null;

	/** @type {?(()=>void)} */
	let fallback = null;

	if(input instanceof HTMLInputElement)
	{
		text = input.value;

		/**
		 * @param {!HTMLInputElement} inputElem
		 * @throw {Error} If browser Legacy Clipboard API failure.
		 */
		fallback = (inputElem) =>
		{
			try
			{
				inputElem.focus();
				inputElem.select();
				inputElem.setSelectionRange(0, input.value.length);
			}
			catch(ex)
			{
				console.error(ex);

				/** @type {!string} */
				let inputId = "";

				/** @type {!string} */
				let inputClass = "";

				/** @type {!string} */
				let inputName = "";

				if(input.id !== undefined)
					inputId = ` id="${input.id}"`;

				if(input.className !== undefined)
					inputClass = ` class="${input.className}"`;

				if(input.name !== undefined)
					inputName = ` name="${input.name}"`;

				/** @const {!string} */
				const tag = `<input ${inputId}${inputClass}${inputName}.../>`

				throw new ClipboardAPIError(`Impossible copy text from ${tag}; an error occur while selecting text.`)
			}

			if(document.execCommand === undefined || document.execCommand === null)
				throw new ClipboardAPIError("Impossible copy text; Legacy Clipboard API not found.");

			if(!document.execCommand("copy"))
				throw new ClipboardAPIError("Impossible copy text; Legacy Clipboard API failure.");
		}
	}

	try
	{
		copyTextToClipboard(text, success, () => {
			try
			{
				fallback(input);
			}
			catch(ex)
			{
				console.error(ex);

				if(failure)
					failure();
			}
		});
	}
	catch(ex)
	{
		console.error(ex);

		try
		{
			fallback(input);
			success();
		}
		catch(ex)
		{
			console.error(ex);

			if(failure)
				failure();
		}
	}
};

