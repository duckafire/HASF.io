<?php

declare(strict_type=1);

namespace App\Controllers;

class Informative extends BaseController
{
	public function home(): string
	{
		helper("html");
		return view("pages/home");
	}

	public function licenses(): string
	{
		helper("html");
		return view("pages/licenses");
	}
}
