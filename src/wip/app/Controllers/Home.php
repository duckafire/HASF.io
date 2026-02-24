<?php

namespace App\Controllers;

class Home extends BaseController
{
	public function index(): string
	{
		helper(["html", "html_plus"]);

		return view("pages/home.php");
	}
}
