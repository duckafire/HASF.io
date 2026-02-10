"use strict";

window.addEventListener("DOMContentLoaded", () =>
{
	const TOD = 30;   // Time Of Delay; a small time can bug the animation
	const TTL = 8000; // Time To Live: 8s
	let   ttt = null; // Time To Transition (it will be defined after insert first element)

	const CONTAINER = (function()
	{
		const ELEM = document.createElement("ul");
		ELEM.className = "notif-container-toast";

		return ELEM;
	})();

	const TEMPLATE = (function()
	{
		const TOAST = document.createElement("li");
		const TCONT = document.createElement("span");
		const TICON = document.createElement("i");
		const TTEXT = document.createElement("span");

		TOAST.className = "notif-toast";
		TCONT.className = "notif-content";
		TICON.className = "notif-icon";
		TTEXT.className = "notif-text";

		TICON.setAttribute("aria-hidden", "true");

		TCONT.appendChild(TICON);
		TCONT.appendChild(TTEXT);

		TOAST.appendChild(TCONT)

		return TOAST;
	})();

	const PARSER = new DOMParser();

	const ICONS = {
		// Lucide Icons
		error: PARSER.parseFromString('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-octagon-x-icon lucide-octagon-x"><path d="m15 9-6 6"/><path d="M2.586 16.726A2 2 0 0 1 2 15.312V8.688a2 2 0 0 1 .586-1.414l4.688-4.688A2 2 0 0 1 8.688 2h6.624a2 2 0 0 1 1.414.586l4.688 4.688A2 2 0 0 1 22 8.688v6.624a2 2 0 0 1-.586 1.414l-4.688 4.688a2 2 0 0 1-1.414.586H8.688a2 2 0 0 1-1.414-.586z"/><path d="m9 9 6 6"/></svg>', "text/xml").firstChild,
		info:  PARSER.parseFromString('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-badge-info-icon lucide-badge-info"><path d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 4 4 0 0 1 0-6.76Z"/><line x1="12" x2="12" y1="16" y2="12"/><line x1="12" x2="12.01" y1="8" y2="8"/></svg>', "text/xml").firstChild,
		ok:    PARSER.parseFromString('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-check-big-icon lucide-circle-check-big"><path d="M21.801 10A10 10 0 1 1 17 3.335"/><path d="m9 11 3 3L22 4"/></svg>', "text/xml").firstChild,
		warn:  PARSER.parseFromString('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-triangle-alert-icon lucide-triangle-alert"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3"/><path d="M12 9v4"/><path d="M12 17h.01"/></svg>', "text/xml").firstChild,
	};

	window.createNotifToast = (type, textContent) =>
	{
		let typeClass, typeIcon;
		switch(type)
		{
			case "error": typeClass = "notif-error"; typeIcon = ICONS.error; break;
			case "info":  typeClass = "notif-info";  typeIcon = ICONS.info;  break;
			case "ok":    typeClass = "notif-ok";    typeIcon = ICONS.ok;    break;
			case "warn":  typeClass = "notif-warn";  typeIcon = ICONS.warn;  break;
			default: throw new Error(`Invalid type: ${type}.`);
		}

		const TPT = TEMPLATE.cloneNode(true);
		TPT.classList.add( typeClass );

		TPT.querySelector(".notif-icon").appendChild( typeIcon.cloneNode(true) );
		TPT.querySelector(".notif-text").textContent = " " + textContent;

		if(CONTAINER.children.length === 0)
			CONTAINER.appendChild( TPT );
		else
			CONTAINER.insertBefore( TPT, CONTAINER.children[0] );

		if(ttt === null)
			ttt = (parseFloat( getComputedStyle(TPT).getPropertyValue("--ttt") ) * 2000) + TOD + TTL;

		setTimeout(() => TPT.classList.add( "notif-anim-enter" ), TOD );
		setTimeout(() => TPT.classList.remove( "notif-anim-enter" ), TTL );
		setTimeout(() => CONTAINER.removeChild( TPT ), ttt);
	}

	document.body.append( CONTAINER );
});

