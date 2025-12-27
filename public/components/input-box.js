"use strict";

const CONVERTER = document.getElementById("converter");
const CONVERTER_INPUT_TYPES = Object.freeze([
	"0foo",
	"1foo",
	"2foo",
	"3foo",
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
	for(const TEXT_CONTENT of CONVERTER_INPUT_TYPES)
	{
		option = document.createElement("option");
		option.textContent = TEXT_CONTENT;

		SELECT.appendChild( option );
	}

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
};
