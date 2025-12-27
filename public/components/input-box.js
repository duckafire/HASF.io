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

const inputBox = () =>
{
	const CONTAINER = document.createElement("section");
	const NAV       = document.createElement("nav");
	const TEXT_AREA = document.createElement("textarea");

	const SELECT = document.createElement("select");
	const COPIER = document.createElement("button");

	CONTAINER.className = "converter-input-container";
	NAV.className       = "converter-input-nav";
	TEXT_AREA.className = "converter-input";

	SELECT.className = "converter-input-type";
	COPIER.className = "i-copy converter-output-copier";

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
			navigator.clipboard.writeText( TEXT_AREA.value )
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

		TEXT_AREA.focus();
		TEXT_AREA.select();
		TEXT_AREA.setSelectionRange(0, TEXT_AREA.value.length);

		if(document.execCommand !== undefined && document.execCommand("copy"))
		{
			// copy success notification
			return;
		}

		console.error(new InternalError("Impossible copy!"));
	})

	CONTAINER.appendChild( NAV );
	CONTAINER.appendChild( TEXT_AREA );

	NAV.appendChild( SELECT );
	NAV.appendChild( COPIER );

	CONVERTER.appendChild( CONTAINER );
	INPUT_BOXES.push( CONTAINER );
};
