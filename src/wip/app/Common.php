<?php

declare(strict_types=1);

define("DEF_HASH_ALGO", "sha256");

\define("LOG_DEBUG",     "debug");
\define("LOG_INFO",      "info");
\define("LOG_NOTICE",    "notice");
\define("LOG_WARNING",   "warning");
\define("LOG_ERROR",     "error");
\define("LOG_CRITICAL",  "critical");
\define("LOG_ALERT",     "alert");
\define("LOG_EMERGENCY", "emergency");

class HTTPCode500Exception extends \Exception
{
	__construct(string $level, string $description)
	{
		\log_message($level, $description);
		parent::__construct();
	}
}

