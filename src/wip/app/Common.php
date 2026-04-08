<?php

declare(strict_types=1);

\define("DEF_HASH_ALGO", "sha256");

class HTTPCode500Exception extends \Exception
{
	function __construct(string $level, string $description)
	{
		\log_message($level, $description);
		parent::__construct();
	}
}

