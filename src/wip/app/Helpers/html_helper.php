<?php

declare(strict_types=1);

if(defined("HTML_HELPER_EXTENDED"))
	return;

define("HTML_HELPER_EXTENDED", true);

const COLL_LUCIDE    = 0;
const COLL_BOOTSTRAP = 1;

function svg_icon(string $name, string $collection = COLL_LUCIDE): string
{
	$dir = match($collection)
	{
		COLL_LUCIDE    => "lucide-v0.265.0",
		COLL_BOOTSTRAP => "bootstrap-v1.13.1",
	};

	$content  = \file_get_contents("../public/assets/images/icons/$dir/$name.svg");

	if($content === false)
		$content = "&#xfffd;"; // Replacement Character

	return "<i class=\"svg-icon\" aria-hidden=\"true\">$content</i>";
}

function attr_titles(string $text): string
{
	return "title='$text' aria-label='$text'";
}

function no_translate(bool $notranslateClass = true): string
{
	if($notranslateClass)
		return "translate=\"off\" class=\"notranslate\"";

	return "translate=\"off\"";
}

function simple_btn(string $classes, string | array $iconData, ?string $title = null, ?string $url = null): string
{
	// string $iconData: iconName
	// array  $iconData: [ iconName, iconCollection ]

	$allTitles = ($titles === null ? "" : attr_titles($title));

	if(\is_string($iconData))
		$icon = svg_icon($iconData);
	else
		$icon = svg_icon($iconData[0], $iconData[1]);

	if($url === null)
	{
		$tagName    = "button";
		$otherAttrs = "";
	}
	else
	{
		$tagName    = "a";
		$otherAttrs = "role=\"button\" href=\"$url\"";
	}

	return "<$tagName class=\"$classes\" $allTitles $otherAttrs>$icon</$tagName>";
}

