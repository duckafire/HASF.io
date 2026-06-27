"use strict";

document
	.getElementById("fallback")
	.dataset
	.items
	.split(";")
	.map(pair => pair.split(","))
	.forEach(([filePath, objectName]) =>
{
	// globalThis is safest than window, because
	// it has only global things, unlike window
	// that has browser properties (like innerHeight).
	const globalScope = (typeof globalThis !== "undefined" ? globalThis : window);

	if(objectName in globalScope
	&& globalScope[objectName] !== undefined
	&& globalScope[objectName] !== null)
		return;

	console.warn(
		`Impossible to download file (\`${filePath.split("/").pop()}\`)\n`+
		`Starting attempt to download fallback file...`
	);

	const script = document.createElement("script");
	script.src   = `assets/fallback/${filePath}`;
	script.async = false;

	script.onload  = (ev) => console.info(`Fallback file (\`${ev.target.src.split("/").pop()}\`) downloaded with success.`);
	script.onerror = (ev) => console.error(`Impossible to download fallback file (\`${ev.target.src.split("/").pop()}\`).`);

	document.head.appendChild(script);
});

