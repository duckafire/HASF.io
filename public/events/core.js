"use strict";

const __isUnicode__ = (tbox, charf) => (tbox.querySelector( charf ).value === "NaN");

const __coreParser__ = (str, fromUn, toUn, curBase, nextBase) =>
{
	let result = "", fullChar = "";
	let curChar, parsedFullChar;

	if(curBase === nextBase)
		return str;

	for(let i = 0; i < str.length || fullChar !== ""; i++)
	{
		// If `false` and `!fromUn`, it means all
		// string was interated, but a group was
		// not proccessed. So this "preparation"
		// step (bellow) will be jumping and the
		// group will be proccessed correctly.
		if(i < str.length)
		{
			curChar = str.charAt(i);

			if(fromUn && toUn)
			{
				result += curChar;
				fullChar = "";
				continue;
			}

			if(fromUn)
			{
				// Character by character.
				fullChar += curChar;
			}
			// !fromUn &&
			else if(curChar !== " ")
			{
				// "Group" by "group";
				// (10 -> binary GROUP)
				fullChar += curChar;
				continue;
			}
		}

		// Convert to decimal.
		parsedFullChar = (fromUn
			? fullChar.codePointAt() : (curBase === "10"
				? fullChar
				: parseInt( fullChar, curBase )
			));

		result += (toUn
			? String.fromCodePoint( parsedFullChar )
			: parsedFullChar.toString( nextBase ) + " "
		);


		fullChar = "";
	}

	return result;
};

const CORE = () =>
{
	const MAX = TBOXES.len() - 1;
	let curTbox, nextTbox;

	const INPUT_CLASS = ".tbox-input";
	const CHARF_CLASS = ".tbox-char-format-js";

	for(let i = 0; i < MAX; i++)
	{
		curTbox  = TBOXES.get(i);
		nextTbox = TBOXES.get(i + 1);

		nextTbox.querySelector( INPUT_CLASS ).value = __coreParser__(
			curTbox.querySelector( INPUT_CLASS ).value,
			__isUnicode__(curTbox, CHARF_CLASS),
			__isUnicode__(nextTbox, CHARF_CLASS),
			curTbox.querySelector( CHARF_CLASS ).value,
			nextTbox.querySelector( CHARF_CLASS ).value,
		);
	}
};

