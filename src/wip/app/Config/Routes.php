<?php

use \CodeIgniter\Router\RouteCollection;

$routes->view("/",                     "pages/home");

$routes->view("/licenses",             "pages/licenses");

$routes->view("/convert/cipher",       "pages/convert/cipher");
$routes->view("/convert/code",         "pages/convert/code");
$routes->view("/convert/encoding",     "pages/convert/encoding");
$routes->view("/convert/number",       "pages/convert/number");

$routes->view("/create/hash",          "pages/create/hash");

