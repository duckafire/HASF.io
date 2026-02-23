"use strict";

class InvalidEncodingError extends Error
{}

const valNumCode = (input, validUnits) =>
{
	for(const c of input)
		for(const u of validUnits)
			if(c == u)
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

	if(outputType == 0)
		OUTPUT.textContent = String.fromCodePoint( code );
	else
		OUTPUT.textContent = code.toString( outputType );

	OUTPUT.className = "tbox-txt-unit";

	return OUTPUT;
};

const navInTBoxContent = (inputTBox, outputTBox, isFormated = false) =>
{
	const INPUT_TYPE  = inputTBox.querySelector(".tbox-mode").value;
	const OUTPUT_TYPE = inputTBox.querySelector(".tbox-mode").value;

	if(isFormated)
	{
		for(const span of inputTBox.childNodes)
			outputTBox.appendChild( convertCharTo( span.textContent, INPUT_TYPE, OUTPUT_TYPE ) );

		return;
	}

	for(const c of inputTBox.textContent)
		outputTBox.appendChild( convertCharTo( c, INPUT_TYPE, OUTPUT_TYPE ) );
};

