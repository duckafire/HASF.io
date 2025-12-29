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

(function()
{
	const POPUP = document.getElementById("dnt-popup");
	const MAN   = document.getElementById("dnt-btn");

	MAN.addEventListener("click", () =>
	{
		if(POPUP.style.display === "")
		{
			// closing
			POPUP.style.display = "none";
			POPUP.setAttribute("inert", "inert");
			return;
		}

		// opening
		POPUP.style.display = "";
		POPUP.removeAttribute("inert");
	});
})();

document.getElementById("create-input-box").addEventListener("click", () =>
{
	newTBox();
});
