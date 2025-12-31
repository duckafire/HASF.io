"use strict";

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

document.getElementById("copy-all-content").addEventListener("click", () =>
{
	let result = "";

	for(let i = 0; i < TBOXES.len(); i++)
		result += TBOXES.get(i).querySelector(".tbox-input").value + "\n\n";

	copyTextFromInputElem(result);
});

document.getElementById("converter-runner").addEventListener("click", CORE);

document.getElementById("create-input-box").addEventListener("click", newTBox);
