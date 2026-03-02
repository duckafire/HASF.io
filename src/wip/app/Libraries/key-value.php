<?php

// This is fastest than file cache of CI4,
// because it:
// * reads file once;
// * increments file (instead rewrite it); and
// * stores data in as an array (that is updated
//   together with file).

declare(strict_types=1);

namespace App\Libraries\KeyValue;

const KV_LINE_SEPARATOR = "\n";
const KV_PAIR_SEPARATOR = "\t";

function kv_format(string $key, string $value): string
{
	return $key . KV_PAIR_SEPARATOR . $value . KV_LINE_SEPARATOR;
}

function kv_decode(string $filePath): ?array
{
	if(($content = \file_get_contents($filePath)) === false)
		return null;

	$data = [];

	if(!\empty( ($content = \trim($content)) ))
		foreach(\explode( KV_LINE_SEPARATOR, $content ) as &$pair)
			$data[ \strtok($pair, KV_PAIR_SEPARATOR) ] = \strtok(KV_PAIR_SEPARATOR);

	return $data;
}

function kv_encode(string $destFile, array &$data): bool
{
	$content = "";

	foreach($data as $key => &$value)
		$content .= kv_format($key, $value);

	return (\file_put_contents($destFile, $content) !== false);
}

function kv_increment(string $destFile, array &$data, string $key, string $value): bool
{
	if(\file_put_contents($destFile, kv_format($key, $value), FILE_APPEND) === false)
		return false;

	$data[ $key ] = $value;
	return true;
}

