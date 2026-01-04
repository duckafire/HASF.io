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

(function()
{
	// Values based `#TBOXES-OPT`,
	// from `style.css`.
	const WIDTH = 672;

	const TBOXES_NAV     = document.getElementById("tboxes-nav");
	const TBOXES_ASIDE   = document.getElementById("tboxes-aside");
	const TBOXES_MAN_OPT = document.getElementById("tboxes-man-opt");

	const EV = () =>
	{
		if(window.innerWidth < WIDTH && TBOXES_MAN_OPT.dataset.parent !== "nav")
		{
			TBOXES_MAN_OPT.dataset.parent = "nav"
			TBOXES_NAV.style.display = "";
			TBOXES_NAV.appendChild( TBOXES_MAN_OPT );
		}
		else if(window.innerWidth >= WIDTH && TBOXES_MAN_OPT.dataset.parent !== "aside")
		{
			TBOXES_MAN_OPT.dataset.parent = "aside";
			TBOXES_NAV.style.display = "none";
			TBOXES_ASIDE.appendChild( TBOXES_MAN_OPT );
		}
	}

	window.addEventListener("resize", EV);
	window.addEventListener("DOMContentLoaded", EV);
})();

const __colorSchemeEvBehavior__ = (ev) =>
{
	if(ev.matches)
	{
		if(document.documentElement.dataset.colorScheme !== "dark")
			document.documentElement.dataset.colorScheme = "dark";

		return;
	}

	if(document.documentElement.dataset.colorScheme !== "light")
		document.documentElement.dataset.colorScheme = "light";
};

window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change", __colorSchemeEvBehavior__);
window.addEventListener("DOMContentLoaded", () => __colorSchemeEvBehavior__(matchMedia("(prefers-color-scheme: dark)")));
