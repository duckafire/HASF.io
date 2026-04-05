<?php

declare(strict_types=1);

if(\defined("HTML_HELPER_EXTENDED"))
	return;

\define("HTML_HELPER_EXTENDED", true);

\define("COLL_LUCIDE",          0);
\define("COLL_BOOTSTRAP",       1);
\define("COLL_SIMPLE_ICON",     2);

function svg_icon(string $name, int $collection = \COLL_LUCIDE): string
{
	$dir = match($collection)
	{
		\COLL_LUCIDE          => "lucide-v0.265.0",
		\COLL_BOOTSTRAP       => "bootstrap-v1.13.1",
		\COLL_SIMPLE_ICON     => "simple-icons-v16.14.0",
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

	$allTitles = ($titles === null ? "" : \attr_titles($title));

	if(\is_string($iconData))
		$icon = \svg_icon($iconData);
	else
		$icon = \svg_icon($iconData[0], $iconData[1]);

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
			throw new \HTTPCode500Exception(\LOG_ALERT, "Impossible to get real path of: $relativeFilePath");

		$filename = \pathinfo($relativeFilePath, \PATHINFO_FILENAME);
		$extname  = \pathinfo($relativeFilePath, \PATHINFO_EXTENSION);

		$hashedAbsoluteFilePath = \dirname($absoluteFilePath)."/$filename.*.$extname";
		$globedFilePath         = \glob($hashedAbsoluteFilePath);

		if($globedFilePath === false || \count($globedFilePath) === 0)
			throw new \HTTPCode500Exception(\LOG_ALERT, "Impossible to apply GLOB algorithm to: $hashedAbsoluteFilePath");

		return \base_url($globedFilePath[0]);
	}

	// start manifest variable
	if($manifest === null)
	{
		$manifest = \file_get_contents(\ROOTPATH."/readonly/assets-manifest.json");

		if($manifest === false)
		{
			\log_message("error", "Impossible to read assets-manifest.json");
			return \asset($relativeFilePath);
		}

		try
		{
			$manifest = \json_decode($manifest, true);
		}
		catch(\ValueError $ex)
		{
			$manifest = false;
			\log_message("error", $ex.getMessage());
			return \asset($relativeFilePath);
		}

		if($manifest === null)
		{
			$manifest = false; // enable fallback
			\log_message("error", "Impossible to decode assets-manifest.json");
			return \asset($relativeFilePath);
		}
	}

	// normal return
	return \rtrim(\base_url($manifest["assets/$relativeFilePath"]), "/");
}

function default_components(array? $data = [])
{
	return [
		"head"       => (isset($data["head"]) ? view("components/default/head", $data["head"]) : view("components/default/head")),
		"nav"        => view("components/default/nav"),
		"footer"     => view("components/default/footer"),
	];
}

