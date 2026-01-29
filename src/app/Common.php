<?php

declare(strict_types=1);

function include_component(string $name, array $data = [], array $options = [])
{
	echo view("components/$name", $data, $options);
}

