"use strict";

const valArrowFun = (arrowFun) => (typeof arrowFun === "function" && arrowFun());

const __copyTextFromInputElemFallback__ = (elem, behaviors) =>
{
	valArrowFun( behaviors.failure );

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

const copyTextFromInputElem = (elem, behaviors = {}) =>
{
	if(navigator.clipboard === undefined || navigator.clipboard.writeText === undefined)
		return __copyTextFromInputElemFallback__(elem);

	navigator.clipboard.writeText( elem.value )
		.then(() =>
		{
			valArrowFun( behaviors.success );
		})
		.catch(()=>
		{
			__copyTextFromInputElemFallback__(elem);
		});
};
