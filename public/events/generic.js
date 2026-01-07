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

(function()
{
	const CONTAINER = document.getElementById("slide-msg-container");

	const MESSAGES = {
		cache: [],
		source: [
			"Help this project \u2192", // arrow to right
			"THANKS to InifnityFree!",
			"\"H\" of ligHt.",
			"\"A\" of privAte.",
			"\"S\" of faSt.",
			"\"F\" of Free.",
			"Light, private, fast, and FREE!",
			"Forever!",
			"Is this really useful?",
			"We do not catch cookies!",
			"Please, do a donate :D",
		],
	};

	const newSlideMsg = () =>
	{
		let isInCache, msg;
		const MAX = 10;

		for(let i = 0; i < MAX; i++)
		{
			isInCache = false;
			msg = MESSAGES.source[ Math.floor( Math.random() * MESSAGES.source.length ) ];

			for(const ITEM of MESSAGES.cache)
			{
				if(msg === ITEM)
				{
					isInCache = true;
					break;
				}
			}

			if(!isInCache || i === MAX - 1)
			{
				MESSAGES.cache.push( msg );

				if(MESSAGES.cache.length > Math.ceil(MESSAGES.source.length / 2))
					MESSAGES.cache.splice(0, 1);

				break;
			}
		}

		const ELEM = document.createElement("span");

		ELEM.className   = "slice-msg";
		ELEM.textContent = msg;

		ELEM.addEventListener("animationend", () =>
		{
			CONTAINER.removeChild( ELEM );
			newSlideMsg();
		});

		CONTAINER.appendChild( ELEM );
	};

	// boot
	newSlideMsg();
})();
