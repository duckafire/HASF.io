<?php

declare(strict_types=1);

if(!enum_exists("SVGIconOrigin"))
{
	enum SVGIconOrigin
	{
		case LUCIDE;
		case BOOTSTRAP;
	}
}

if(!function_exists("inc_icon"))
{
	function inc_icon(?string $name = null, ?SVGIconOrigin $origin = SVGIconOrigin::LUCIDE): void
	{
		$dir = match($origin)
		{
			SVGIconOrigin::LUCIDE    => "lucide-v0.265.0",
			SVGIconOrigin::BOOTSTRAP => "bootstrap-v1.13.1",
		};

		try {
			$content = \file_get_contents("../public/assets/images/icons/$dir/$name.svg");

		} catch(\Throwable $ex) {
			$content = false;
		}

		if(!$content) // Replacement Character
			$content = "&#xfffd;";

		echo "<i class='svg-icon' aria-hidden='true'>$content</i>";
	}
}

if(!function_exists("inc_attr_titles"))
{
	function inc_attr_titles(string $text): void
	{
		echo "title='$text' aria-label='$text'";
	}
}

if(!function_exists("set_no_translate"))
{
	function set_no_translate(?string $classes = ""): void
	{
		echo "translate='off' class='notranslate $classes'";
	}
}

if(!function_exists("inc_btn"))
{
	function inc_btn(string $classes, string | array $icon, ?string $title = null, ?string $url = null): void
	{
		$allTitles = ($title == null ? "" : "title='$title' aria-label='$title'");

		echo ($url == null
			? "<button          class='$classes' $allTitles>"
			: "<a role='button' class='$classes' $allTitles href='$url'>");

		if($icon != null)
		{
			if(\gettype($icon) == "string")
				inc_icon( $icon );
			else
				inc_icon(icon[0], icon[1]);
		}

		echo ($url == null ? "</button>" : "</a>");
	}
}

if(!function_exists("inc_slt_opt"))
{
	function inc_slt_opt(string $textContent, string $value, bool $isSelected = false): void
	{
		echo "<option value='$value'".($isSelected ? "selected='selected'" : "").">$textContent</option>";
	}
}
