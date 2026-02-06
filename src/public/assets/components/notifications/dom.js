const __GLOBAL_NOTIF_CONTAINER__ = document.getElementById("global-notif-container");

const newNotif = (msg, destine = 0) =>
{
	if(destine !== 0)
	{
		console.warn( new Error(msg) );

		if(destine === -1)
			return;
	}

	const NOTIF = document.createElement("span");

	NOTIF.className   = "global-notif-item";
	NOTIF.textContent = msg;

	NOTIF.addEventListener("animationend", () =>
	{
		NOTIF.parentNode.removeChild( NOTIF );
	});

	__GLOBAL_NOTIF_CONTAINER__.appendChild( NOTIF );
};
