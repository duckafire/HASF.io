<?php

echo '<?xml version="1.0" encoding="UTF-8"?>';

\helper("html");

?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html class="color-scheme-auto" lang="en-US" dir="ltr">
<head>
	<!--+===============================================+-->
	<!--| Copyright (C) 2025-2026 DuckAfire ~~~~~~~~~~~~|-->
	<!--|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|-->
	<!--| This web page is licensed by AGPL3: ~~~~~~~~~~|-->
	<!--| https://www.gnu.org/licenses/agpl-3.0.en.html |-->
	<!--|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|-->
	<!--| Its source code is available in: ~~~~~~~~~~~~~|-->
	<!--| https://github.com/duckafire/HASF.io ~~~~~~~~ |-->
	<!--| https://gitlab.com/duckafire/HASF.io ~~~~~~~~ |-->
	<!--+===============================================+-->
	<title class="notranslate" translate="no">HASF.io</title>
	<link rel="icon" href="favicon.svg?v=1.0.0" type="image/svg+xml"/>

	<meta property="og:title"       content="HASF.io"/>
	<meta property="og:image"       content="https://hasf.io/favicon.svg"/>
	<meta property="og:description" content="Light, private, fast, and FREE (forever)!"/>

	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>

	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js"></script>

	<link rel="stylesheet" type="text/css" href="<?= asset("css/default.css"); ?>"/>

	<script src="<?= asset("js/default.js"); ?>"></script>

<?php

if(!isset($head_tags))
	goto END_OF_THIS_TAG;

const ORIGIN_FIELDS = ["extern", "intern"];
const TYPE_FIELDS   = ["css", "js"];

foreach(ORIGIN_FIELDS as &$origin)
{
	if(!isset($head_tags[$origin]))
		continue;

	$ref =& $head_tags[$origin];

	foreach(TYPE_FIELDS as &$field)
	{
		if(!isset($ref[$field]))
			continue;

		foreach($ref[$field] as &$fileName)
		{
			if($field === TYPE_FIELDS[0])
				echo \link_tag("./assets/$fileName.css");
			else
				echo \link_tag("./assets/$fileName.js");
		}
	}
}

END_OF_THIS_TAG:

?>

</head>
