"use strict";

$(function()
{
	class InvalidEncodingError extends Error
	{}

	const valNumCode = (input, validUnits) =>
	{
		for(const c of input)
			for(const u of validUnits)
				if(c === u)
					return;

		throw new InvalidEncodingError();
	};

	const convertCharTo = (input, inputType, outputType) =>
	{
		const OUTPUT = document.createElement("span");

		// Convert to number
		inputType  = inputType  - 0;
		outputType = outputType - 0;

		try
		{
			switch(inputType)
			{
				case 0: /* Text */ break;
				case 2:  valNumCode( input, "01"                     ); break;
				case 8:  valNumCode( input, "01234567"               ); break;
				case 10: valNumCode( input, "0123456789"             ); break;
				case 16: valNumCode( input, "0123456789abcdefABCDEF" ); break;
			}
		}
		catch(ex)
		{
			OUTPUT.className   = "inv-encoding";
			OUTPUT.textContent = input;
			return OUTPUT;
		}

		let code;

		switch(inputType)
		{
			case 0:  code = input.codePointAt(); break;
			case 10: code = input;               break
			default: code = parseInt( input, inputType );
		}

		if(outputType === 0)
			OUTPUT.textContent = String.fromCodePoint( code );
		else
			OUTPUT.textContent = code.toString( outputType );

		OUTPUT.className = "tbox-txt-unit";

		return OUTPUT;
	};

	const navInTBoxContent = (inputTBox, outputTBox, isFormated = false) =>
	{
		const INPUT_TYPE  =  inputTBox.querySelector(".tbox-tmode").value;
		const OUTPUT_TYPE =  inputTBox.querySelector(".tbox-tmode").value;
		const OUTPUT_TXT  = outputTBox.querySelector(".tbox-txt");

		if(isFormated)
		{
			for(const span of inputTBox.childNodes)
				OUTPUT_TEXT.appendChild( convertCharTo( span.textContent, INPUT_TYPE, OUTPUT_TYPE ) );

			return;
		}

		for(const c of inputTBox.textContent)
			OUTPUT_TXT.appendChild( convertCharTo( c, INPUT_TYPE, OUTPUT_TYPE ) );
	};

	window.TBOXES_API = {
		__container__: $(".tbox-list"),
	};

	TBOXES_API.__items__: [
		TBOXES_API.__container__.find(".tbox"),
		TBOXES_API.__container__.find(".tbox + .tbox"),
	];

	TBOXES_API.__template__ = TBOXES_API.__items__[1];

	TBOXES_API.get = (id) =>
	{
		validType(id, "number");
		return TBOXES_API.__items__[id];
	};

	TBOXES_API.forEach = (arrowFunc, jumpFirst = false) =>
	{
		// arrowFunc parameters:
		// * tbox:  JQuery
		// * index: number
		for(let i = (jumpFirst ? 1 : 0); i < TBOXES_API.__items__.length; i++)
			arrowFunc( TBOXES_API.__items__[i], i );
	};

	TBOXES_API.insert = (target, id = null) =>
	{
		validType(target, "JQuery");

		if(id === null)
		{
			TBOXES_API.__items__.push(target);
			TBOXES_API.__container__.append(target);
			return;
		}

		validType(id, "number");

		TBOXES_API.__items__.splice(id, 0, target);
		TBOXES_API.get(id).before( target );
	};

	TBOXES_API.clone = (original, id = null) =>
	{
		validType(origin);
		TBOXES_API.insert( original.clone(true, true), id );
	};

	TBOXES_API.add = () =>
	{
		TBOXES_API.clone( TBOXES_API.__template__ );
	};

	TBOXES_API.copy = (tbox = null) =>
	{
		if(source !== null)
		{
			if(tbox.data("type") === "input")
			{
				window.copyText( TBOXES_API.get(0).find(".tbox-txt").value );
				return;
			}

			let source = "";

			tbox.childNodes.forEach((snippet) =>
			{
				source += snippet.textContent + " ";
			});

			window.copyText( source );
			return;
		}

		let allSource = TBOXES_API.get(0).find(".tbox-txt").value;

		TBOXES_API.forEach((tbox) =>
		{
			allSource += "\n\n";

			tbox.childNodes.forEach((snippet) =>
			{
				allSource += snippet.textContent + " ";
			});
		}, true);

		window.copyText( allSource );
	};

	TBOXES_API.run = () =>
	{
		// TODO
	};

	window.TBOXES_API = Object.freeze( window.TBOXES_API );
});

