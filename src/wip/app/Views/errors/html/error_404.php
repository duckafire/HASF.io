<?php

declare(strict_types=1);

namespace HasfIO\Error;

?><?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 

<?php

// ERRor COMMon ATTRibutes
function err_comm_attr(?string $title = null)
{
	$noTranslate = 'translate="off" class="notranslate"';

	if($title !== null)
		return "$noTranslate title=\"$title\" aria-label=\"$title\"";

	return $noTranslate;
}

?>

<html lang="en-US" dir="ltr" >
<head>
	<title>Page not found</title>

	<meta charset="utf8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>

	<style>
		html
		{
			--FG: #1f1f1f;
			--BG: #e0e0e0;
			--BOX_SHADOW_COLOR: #606060;
			--ANCHOR_COLOR: #4447e3;
		}

		@media (prefers-color-scheme: dark)
		{
			html
			{
				--FG: #e0e0e0;
				--BG: #1f1f1f;
				--BOX_SHADOW_COLOR: #060606;
				--ANCHOR_COLOR: #69a3ff;
			}
		}

		*
		{
			margin: 0;
			padding: 0;
			box-sizing: border-box;
		}

		body
		{
			color: var(--FG);
			background-color: var(--BG);

			width: 100vw;
			min-height: 100vh;
			min-height: 100dvh;

			font-family: sans, helverica, roboto, trebuchet ms, tahoma, verdana, arial;
		}

		a
		{
			color: var(--ANCHOR_COLOR);
		}

		.error
		{
			margin-top: 3rem;
			margin-inline: 12.5vw;
			padding: 1rem;

			width: 75vw;
			height: max-content;

			display: flex;
			flex-direction: column;
			text-align: center;
			gap: 2.5rem;

			box-shadow: 0.25rem 0.25rem 0.45rem var(--BOX_SHADOW_COLOR);
		}

		h1
		{
			font-size: 3rem;
		}

		.copyright
		{
			display: flex;
			flex-direction: column;
			gap: 0.4em;
			font-size: 1.2rem;
		}

		.phrase,
		.subphase
		{
			display: block;
			text-underline-offset: 0.15rem;
		}

		.phrase
		{
			font-size: 0.85em;
			opacity: 0.8;
		}

		.subphrase
		{
			font-size: 0.75em;
			opacity: 0.7;
		}

		@media only screen and (min-width: 37rem) and (max-width: 64rem)
		{
			.copyright
			{
				font-size: 1.1rem;
			}
		}

		@media only screen and (min-width: 64rem)
		{
			.copyright
			{
				font-size: 1rem;
			}
		}
	</style>
</head>
<body>
	<div class="error">
		<header>
			<h1>Page not found</h1>
			<?php
				if(defined("ENVIRONMENT") && ENVIRONMENT !== "production")
					echo nl2br(esc($message));
			?>
		</header>

		<div class="copyright">
			<span class="phrase">
				<a    <?= err_comm_attr("HASF.io home");     ?> href="https://hasf.io">HASF.io</a>
				<span <?= err_comm_attr();                   ?>>Copyright (C) 2025-2026</span>
				<a    <?= err_comm_attr("DuckAfire's Nest"); ?> href="https://duckafire.gitlab.io/pages/home">DuckAfire</a>
			</span>
			<span class="subphrase">
				<a <?= err_comm_attr("Remote repository on GitHub"); ?> href="https://github.com/duckafire/HASF.io">GitHub</a>
				&#8226;
				<a <?= err_comm_attr("Remote repository of GitLab"); ?> href="https://gitlab.com/duckafire/HASF.io">GitLab</a>
				&#8226;
				<a <?= err_comm_attr("Project license"); ?> href="https://www.gnu.org/licenses/agpl-3.0.en.html">License (AGPL3)</a>
			</span>
		</div>
	</div>
</body>
</html>

