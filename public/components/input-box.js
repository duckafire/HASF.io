"use strict";

const INPUT_BOXES = Object.freeze(new (class
{
	constructor()
	{
		this.__items__ = [];
	}

	push(item)
	{
		this.__items__.push(item);
	}

	get(id)
	{
		return this.__items__[id];
	}

	length()
	{
		return this.__items__.length;
	}

	remove(id)
	{
		this.__items__.splice(id, 1);
	}
}));

const CONVERTER = document.getElementById("converter-grid");
const CONVERTER_INPUT_TYPES = Object.freeze([
	// Update `../events/converter.js`
	// after to change the content of
	// this array.
	"Binary",
	"Octal",
	"Decimal",
	"Hexadecimal",
]);
const CONVERTER_INPUT_ENCODING = Object.freeze([
	"ASCII",
	"UTF-8",
	"ASCII / UTF-8",
]);

const __navSecondLayer__ = (textArea) =>
{
	const CONTAINER = document.createElement("div");
	const SELECT    = document.createElement("select");
	const COPIER    = document.createElement("button");

	CONTAINER.className = "converter-input-nav-item";
	SELECT.className = "converter-input-type";
	COPIER.className = "i-copy converter-nav-btn";

	let option;
	CONVERTER_INPUT_TYPES.forEach((textContent, i) =>
	{
		option = document.createElement("option");
		option.textContent = textContent
		option.value = i.toString();

		SELECT.appendChild( option );
	});

	COPIER.addEventListener("click", () =>
	{
		if(navigator.clipboard !== undefined && navigator.clipboard.writeText !== undefined)
		{
			navigator.clipboard.writeText( textArea.value )
				.then(() =>
				{
					// copy success notification
				})
				.catch((ex) =>
				{
					console.error(ex);
				});
			return;
		}

		textArea.focus();
		textArea.select();
		textArea.setSelectionRange(0, textArea.value.length);

		if(document.execCommand !== undefined && document.execCommand("copy"))
		{
			// copy success notification
			return;
		}

		console.error(new InternalError("Impossible copy!"));
	});

	CONTAINER.appendChild( SELECT );
	CONTAINER.appendChild( COPIER );
	return CONTAINER;
};

const __navFirstLayer__ = (inputBox, inputBoxId) =>
{
	const CONTAINER = document.createElement("div");
	const SELECT    = document.createElement("select");
	const TRASH     = document.createElement("button");

	CONTAINER.className = "converter-input-nav-item";
	SELECT.className = "converter-input-type";
	TRASH.className  = "i-trash converter-nav-btn";

	let option;
	CONVERTER_INPUT_ENCODING.forEach((textContent, i) =>
	{
		option = document.createElement("option");
		option.textContent = textContent
		option.value = i.toString();

		SELECT.appendChild( option );
	});

	TRASH.addEventListener("click", () =>
	{
		INPUT_BOXES.remove( inputBoxId );
		CONVERTER.removeChild( inputBox );
	});

	CONTAINER.appendChild( SELECT );
	CONTAINER.appendChild( TRASH  );
	return CONTAINER;
};

const inputBox = () =>
{
	const CONTAINER = document.createElement("section");
	const NAV       = document.createElement("nav");
	const TEXT_AREA = document.createElement("textarea");

	CONTAINER.className = "converter-input-container";
	NAV.className       = "converter-input-nav";
	TEXT_AREA.className = "converter-input";

	CONTAINER.appendChild( NAV );
	CONTAINER.appendChild( TEXT_AREA );

	NAV.appendChild( __navFirstLayer__( CONTAINER, INPUT_BOXES.length ) );
	NAV.appendChild( __navSecondLayer__(TEXT_AREA) );

	CONVERTER.appendChild( CONTAINER );
	INPUT_BOXES.push( CONTAINER );
};
