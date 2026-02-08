<?php

declare(strict_types=1);

function include_icon(?string $name = null): void
{
	try {
		$content = file_get_contents("../public/assets/lucide-icons-v0.265.0/$name.svg");

	} catch(\Throwable $ex) {
		$content = false;
	}

	if(!$content) // Replacement Character
		$content = "&#xfffd;"

	echo "<i class='lucide-icon'>$content</i>";
}

