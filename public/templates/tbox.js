"use strict";

const TBOXES_CONTAINER = document.getElementById("tboxes-container");
const TBOX_TEMPLATE    = document.getElementById("tpt-tbox").content.children[0];

const TBOXES = Object.freeze(new (class
{
	constructor()
	{
		this.__items__ = [];
	}

	push(item)
	{
		this.__items__.push(item);
		item.dataset.listId = this.__items__.length;
	}

	get(id)
	{
		return this.__items__[id];
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
			this.__items__[id] = undefined;
			return;
		}

		for(let i = id; i < MAX; i++)
		{
			this.__items__[i] = this.__items__[i + 1];
			this.__items__[i].dataset.listId = i;
		}
	}
}));

const newTBox = () =>
{
	const TBOX = TBOX_TEMPLATE.cloneNode(true);

	if(TBOXES.len() === 0)
	{
		TBOX.dataset.type = "input";
		TBOX.querySelector(".tbox-input").placeholder = "Write here.";
	}
	else
	{
		TBOX.dataset.type = "output";
		const INPUT = TBOX.querySelector(".tbox-input");
		INPUT.placeholder = "Result from past cell.";
		INPUT.readOnly = "readonly";
	}

	TBOXES.push(TBOX);
	TBOXES_CONTAINER.appendChild(TBOX);
};

