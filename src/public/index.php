<?php

use CodeIgniter\Boot;
use Config\Paths;

// Front Controller PATH
define("FCPATH", __DIR__."/");

if(getcwd()."/" !== FCPATH)
	chdir(FCPATH);

require FCPATH."../app/Config/Paths.php";
require FCPATH."../system/Boot.php";

exit(Boot::bootWeb( new Paths() ));

