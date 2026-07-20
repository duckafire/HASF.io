"use strict";

/**
 *   <script> that imports this script always must
 * follow some rules:
 *
 * * #fallback must be its ID (it uses itself);
 * * data-items must be one of its attributes; and
 * * data-items must contains a semi-colon-separated list
 *   (into string) or an empty string.
 *
 *   (data-items list contains comma-separated pairs,
 * where first value is a path to the fallback of a
 * third party library and second is a global "stuff"
 * declared by it.
 *
 *   They are used to validate if the library was
 * correclty downloaded; if the object was declared all
 * it is OK, else fallback will be downloaded.)
 */

document
	.getElementById("fallback")
	.dataset
	.items
	.split(";")
	.map(pair => pair
		.split(",")
		.map(item => item.trim()))
	.forEach(([filePath, objectName]) =>
{
	/**
	 * GlobalThis is safest than window, because
	 * it has only global things, unlike window
	 * that has browser properties (like innerHeight).
	 *
	 * @const {!(typeof GlobalThis | Window)}
	 */
	const globalScope = (typeof globalThis !== "undefined" ? globalThis : window);

	if(objectName in globalScope
	&& globalScope[objectName] !== undefined
	&& globalScope[objectName] !== null)
		return;

	console.warn(
		`Impossible to download file (\`${filePath.split("/").pop()}\`)\n`+
		`Starting attempt to download fallback file...`
	);

	/** @const {!HTMLScriptElement} */
	const script = document.createElement("script");
	script.src   = `assets/fallback/${filePath}`;
	script.async = false;

	script.onload  = (ev) => console.info(`Fallback file (\`${ev.target.src.split("/").pop()}\`) downloaded with success.`);
	script.onerror = (ev) => console.error(`Impossible to download fallback file (\`${ev.target.src.split("/").pop()}\`).`);

	document.head.appendChild(script);
});

