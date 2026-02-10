<?php

declare(strict_types=1);

if(!enum_exists("EIcons"))
{
	enum EIcons
	{
		case LUCIDE;
		case BOOTSTRAP;
	}
}

if(!function_exists("inc_icon"))
{
	function inc_icon(?string $name = null, ?EIcon $origin = EIcon::LUCIDE): void
	{
		$dir = match($origin)
		{
			EIcon::LUCIDE    => "lucide-v0.265.0",
			EIcon::BOOTSTRAP => "bootstrap-v1.13.1",
		};

		try {
			$content = file_get_contents("../public/assets/icons/$dir/$name.svg");

		} catch(\Throwable $ex) {
			$content = false;
		}

		if(!$content) // Replacement Character
			$content = "&#xfffd;";

		echo "<i class='lucide-icon' aria-hidden='true'>$content</i>";
	}
}

if(!function_exists("inc_attr_titles"))
{
	function inc_attr_titles(string $text)
	{
		echo "title='$text' aria-label='$text'";
	}
}

if(!function_exists("set_no_translate"))
{
	function set_no_translate(?string $classes = "")
	{
		echo "translate='off' class='notranslate $classes'";
	}
}

