<?php

// Fallback to htaccess (if it cannot
// redirect user because some modules
// are unavailable or other problem).
//
// (URI_ROOT is a "template macro".)

$_SERVER["SCRIPT_NAME"] = "/${URI_ROOT}/public/index.php";
require __DIR__ . $_SERVER["SCRIPT_NAME"];

