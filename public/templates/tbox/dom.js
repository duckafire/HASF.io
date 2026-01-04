"use strict";

const TBOXES_CONTAINER = document.getElementById("tboxes-container");
const TBOX_TEMPLATE    = document.getElementById("tpt-tbox").content.children[0];

const TBOXES = Object.freeze(new (class
{
	constructor()
	{
		this.__items__ = [];
	}

	__updateIds__(id, max = this.__items__.length)
	{
		for(let i = id; i < max; i++)
			this.__items__[i].dataset.listId = i;
	}

	push(item)
	{
		item.dataset.listId = this.__items__.length;
		this.__items__.push(item);
	}

	insert(item, id)
	{
		item.dataset.listId = id;
		this.__items__.splice(id, 0, item);
		this.__updateIds__(id);
	}

	get(id)
	{
		return this.__items__[ parseInt(id) ];
	}

	len()
	{
		return this.__items__.length;
	}

	rm(id)
	{
		id = parseInt(id);
		const MAX = this.__items__.length - 1;

		if(id === MAX)
		{
			this.__items__.pop();
			return;
		}

		this.__items__.splice(id, 1);
		this.__updateIds__(id, MAX);
	}
}));

const __evCloneTBox__ = (comp) =>
{
	const ID = parseInt(comp.dataset.listId);
	const CLONE = TBOXES.get( ID ).cloneNode(true);
	const POSITION_REFERENCE = (
		ID !== TBOXES.len() - 1
			? TBOXES.get( ID + 1 )
			: null
	);

	if(ID === 0)
	{
		// type:input -> type:output
		const BTN_DEL = document.createElement("button");
		const INPUT   = CLONE.querySelector(".tbox-input");

		BTN_DEL.className = "tbox-btn-delete tbox-btn";
		BTN_DEL.innerHTML = '<span class="i-trash"></span>';

		INPUT.setAttribute("readonly", true);
		INPUT.placeholder = "Result from past cell.";

		CLONE.dataset.type = "output";
		CLONE.querySelector(".tbox-nav").appendChild( BTN_DEL );
	}

	const SLT_CLASS = ".tbox-char-format-js";
	CLONE.querySelector( SLT_CLASS ).value = TBOXES.get( ID ).querySelector( SLT_CLASS ).value;

	__applyTBoxEvents__(CLONE);

	if(POSITION_REFERENCE !== null)
	{
		TBOXES.insert(CLONE, ID + 1);
		TBOXES_CONTAINER.insertBefore(CLONE, POSITION_REFERENCE);
		return;
	}

	TBOXES.push(CLONE);
	TBOXES_CONTAINER.appendChild(CLONE);
};

const __evCopyTBox__ = (comp, inputArea) =>
{
	copyTextFromInputElem(comp.querySelector(".tbox-input"));
};

const __evDeleteTBox__ = (comp) =>
{
	// TODO: confirm action
	TBOXES.rm( comp.dataset.listId );
	TBOXES_CONTAINER.removeChild( comp );
};

const __applyTBoxEvents__ = (comp) =>
{
	const INPUT_AREA = comp.querySelector(".tbox-input");
	const BTN_DEL    = comp.querySelector(".tbox-btn-delete");

	comp.querySelector(".tbox-btn-clone").addEventListener("click", () => __evCloneTBox__(comp));
	comp.querySelector(".tbox-btn-copy").addEventListener("click", () => __evCopyTBox__(comp, INPUT_AREA));

	if(BTN_DEL !== null)
		BTN_DEL.addEventListener("click", () => __evDeleteTBox__(comp));
};

const newTBox = () =>
{
	const TBOX = TBOX_TEMPLATE.cloneNode(true);

	if(TBOXES.len() === 0)
	{
		TBOX.dataset.type = "input";
		TBOX.querySelector(".tbox-nav").removeChild( TBOX.querySelector(".tbox-btn-delete") );

		const INPUT = TBOX.querySelector(".tbox-input");

		INPUT.placeholder = "Write here.";
		INPUT.removeAttribute("tabindex");
		INPUT.removeAttribute("readOnly");
	}

	__applyTBoxEvents__(TBOX);
	TBOXES.push(TBOX);
	TBOXES_CONTAINER.appendChild(TBOX);
};

