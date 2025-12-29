"use strict";

document.getElementById("converter-runner").addEventListener("click", () =>
{
	const MAX = TBOXES.len() - 1;
	const INPUT_CLASS = ".tbox-input";
	let cur, input, output;

	for(let i = 0; i < MAX; i++)
	{
		cur = TBOXES.get(i);
		input  = cur.querySelector( INPUT_CLASS );
		output = TBOXES.get( i + 1 ).querySelector( INPUT_CLASS );

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
