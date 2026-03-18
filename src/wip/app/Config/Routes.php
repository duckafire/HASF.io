<?php

use \CodeIgniter\Router\RouteCollection;

$routes->view("/", "pages/home");

$routes->view("/licenses", "pages/licenses");

$routes->view("/conv/base",     "pages/conv/base");
$routes->view("/conv/cipher",   "pages/conv/cipher");
$routes->view("/conv/encoding", "pages/conv/encoding");
$routes->view("/conv/hash",     "pages/conv/hash");
$routes->view("/conv/number",   "pages/conv/number");

