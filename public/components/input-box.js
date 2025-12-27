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
	const BUTTON = document.createElement("button");

	CONTAINER.className = "converter-input-container";
	NAV.className       = "converter-input-nav";
	TEXT_AREA.className = "converter-input";

	SELECT.className = "converter-input-type";
	BUTTON.className = "i-copy converter-output-copier";

	let option;
	for(const TEXT_CONTENT of CONVERTER_INPUT_TYPES)
	{
		option = document.createElement("option");
		option.textContent = TEXT_CONTENT;

		SELECT.appendChild( option );
	}

	CONTAINER.appendChild( NAV );
	CONTAINER.appendChild( TEXT_AREA );

	NAV.appendChild( SELECT );
	NAV.appendChild( BUTTON );

	CONVERTER.appendChild( CONTAINER );
};
