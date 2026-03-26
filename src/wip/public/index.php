<?php

use \CodeIgniter\Boot;
use \Config\Paths;

\define("FCPATH", __DIR__."/");
\define("READONLY_PATH", __DIR__."/../readonly/");

if(\getcwd()."/" !== \FCPATH)
	\chdir(\FCPATH);

require \FCPATH."../app/Config/Paths.php";

$paths = new Paths();

require $paths->systemDirectory."/Boot.php";

exit(Boot::bootWeb($paths));

