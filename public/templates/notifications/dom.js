const __GLOBAL_NOTIF_CONTAINER__ = document.getElementById("global-notif-container");
let __notifTimeOfLive__ = null;

const newNotif = (msg, destine) =>
{
	if(destine)
	{
		console.warn( new Error(msg) );

		if(destine === -1)
			return;
	}

	const NOTIF = document.createElement("span");

	NOTIF.className   = "global-notif-item";
	NOTIF.textContent = msg;

	if(__notifTimeOfLive__ === null)
	{
		// Append it before to compute
		// `--time-of-live` value.
		__GLOBAL_NOTIF_CONTAINER__.appendChild( NOTIF );
		__notifTimeOfLive__ = parseInt( getComputedStyle( NOTIF ).getPropertyValue("--time-of-live") ) * 1000;
	}

	setTimeout(() =>
	{
		NOTIF.parentNode.removeChild( NOTIF );
	}, __notifTimeOfLive__);

	// Append it after to avoid
	// visual bugs.
	__GLOBAL_NOTIF_CONTAINER__.appendChild( NOTIF );
};
