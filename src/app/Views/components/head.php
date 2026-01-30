<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en-US" dir="ltr" data-color-scheme=" ">
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
	<!--+===================================================-->
	<title class="notranslate" translate="no">HASF.io</title>
	<link rel="icon" href="./assets/images/pixel-art/hasf-io-short-brand.png"/>

	<meta property="og:title"       content="HASF.io"/>
	<!-- <meta property="og:image"       content=""/> -->
	<meta property="og:description" content="Light, private, fast, and FREE (forever)!"/>

	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>

	<link rel="stylesheet" type="text/css" href="./style/default.css"/>
	<link rel="stylesheet" type="text/css" href="./style/generic.css"/>

<?php

if(!isset($head_tags))
	goto END_OF_TAG;

helper("html");

function insert_requirer_tags($dt, $field)
{
	if(!isset($dt[$field]))
		return;

	$ref = $dt[$field];
	$FIELDS = ["css", "js"];

	foreach($FIELDS as $field)
		if(isset($ref[$field]))
			foreach($ref[$field] as $stuff) // $stuff === $href || $src
				echo ($field == $FIELDS[0]
					? link_tag($stuff.".css")
					: script_tag($stuff.".js"));
}

insert_requirer_tags($head_tags, "extern");
insert_requirer_tags($head_tags, "intern");

END_OF_TAG:

?>

</head>
