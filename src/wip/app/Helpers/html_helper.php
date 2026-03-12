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

function asset(string $relativeFilePath): string
{
	static $manifest = null;

	// fallback
	if($manifest === false)
	{
		$absoluteFilePath = \realpath($relativeFilePath);

		if($absoluteFilePath === false)
		{
			$errorMessage = "Impossible to get real path of: $relativeFilePath";
			log_message("critical", $errorMessage);
			throw new \RuntimeException($errorMessage); // invoke error page 500
		}

		$filename = \pathinfo($relativeFilePath, PATHINFO_FILENAME);
		$extname  = \pathinfo($relativeFilePath, PATHINFO_EXTENSION);

		$hashedAbsoluteFilePath = \dirname($absoluteFilePath)."/$filename.*.$extname");
		$globedFilePath         = \glob($hashedAbsoluteFilePath);

		if($globedFilePath === false || \count($globedFilePath) === 0)
		{
			$errorMessage = "Impossible to apply GLOB algorithm to: $hashedAbsoluteFilePath";
			log_message("critical", $errorMessage);
			throw new \RuntimeException($errorMessage); // invoke error page 500
		}

		return base_url("{$globedFilePath[0]}");
	}

	// start manifest variable
	if($manifest === null)
	{
		$manifest = \file_get_contents(ROOTPATH."/assets-manifest.json");

		if($manifest === false)
		{
			log_message("error", "Impossible to read assets-manifest.json");
			return asset($relativeFilePath);
		}

		$manifest = \json_decode($manifest);

		if($manifest === null)
		{
			$manifest = false; // enable fallback
			log_message("error", "Impossible to decode assets-manifest.json");
			return asset($relativeFilePath);
		}
	}

	// normal return
	return base_url($manifest[$relativeFilePath]);
}

