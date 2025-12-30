"use strict";

const valArrowFun = (arrowFun) => (typeof arrowFun === "function" && arrowFun());

const __copyTextFromInputElemFallback__ = (elem, isString, behaviors) =>
{
	valArrowFun( behaviors.failure );

	if(isString)
		return;

	elem.focus();
	elem.select();
	elem.setSelectionRange(0, elem.value.length);

	if(document.execCommand === undefined || !document.execCommand("copy"))
	{
		valArrowFun( behaviors.fallbackFailure );
		return;
	}

	valArrowFun( behaviors.success );
};

const copyTextFromInputElem = (input, behaviors = {}) =>
{
	const IS_STRING = (typeof input === "string");

	if(navigator.clipboard === undefined || navigator.clipboard.writeText === undefined)
		return __copyTextFromInputElemFallback__(input, IS_STRING, behaviors);

	navigator.clipboard.writeText( IS_STRING ? input : input.value )
		.then(() =>
		{
			valArrowFun( behaviors.success );
		})
		.catch(()=>
		{
			__copyTextFromInputElemFallback__(input, IS_STRING, behaviors);
		});
};
