<?php

use \CodeIgniter\Router\RouteCollection;

$routes->view("/", "home");

$routes->view("/licenses", "licenses");

$routes->view("/conv/base",     "conv/base");
$routes->view("/conv/cipher",   "conv/cipher");
$routes->view("/conv/encoding", "conv/encoding");
$routes->view("/conv/hash",     "conv/hash");
$routes->view("/conv/number",   "conv/number");

