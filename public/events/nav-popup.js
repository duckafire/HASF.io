"use strict";

(function()
{
	const POPUP = document.getElementById("dnt-popup");
	const MAN   = document.getElementById("dnt-btn");

	MAN.addEventListener("click", () =>
	{
		if(POPUP.style.display === "")
		{
			POPUP.style.display = "none";
			POPUP.setAttribute("inert", "inert");
			return;
		}

		POPUP.style.display = "";
		POPUP.removeAttribute("inert");
	});
})();
