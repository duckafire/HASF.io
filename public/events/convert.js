"use strict";

document.getElementById("converter-runner").addEventListener("click", () =>
{
	const MAX = INPUT_BOXES.length() - 1;
	let cur, input, output;

	for(let i = 0; i < MAX; i++)
	{
		cur = INPUT_BOXES.get(i);
		input  = cur.querySelector(".converter-input");
		output = INPUT_BOXES.get( i + 1 ).querySelector(".converter-input");

		output.value = input.value; // TMP

		/* TODO
		switch( cur.querySelector(".converter-input-type").value )
		{
			case "0": break;
			case "1": break;
			case "2": break;
			case "3": break;
		}*/
	}
});
