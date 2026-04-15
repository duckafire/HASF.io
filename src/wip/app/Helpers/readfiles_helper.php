<?php

declare(strict_types=1);

if(\defined("READFILES_HELPER"))
	return;

\define("READFILES_HELPER", true);

function extractFileContent(string $filePath): ?string
{
	if(!\file_exists($filePath))
	{
		\log_message("alert", "Inexistent file: $filePath");
		return null;
	}

	if(!\is_readable($filePath))
	{
		\log_message("alert", "No permission to read the file: $filePath");
		return null;
	}

	return \file_get_contents($filePath);
}

function jsonToArray(string $filePath): ?string
{
	$content = \extractFileContent($filePath);

	if($content === null)
		return null;

	$content = \json_decode($content, true);

	if($content === null)
		\log_message("Impossible decode JSON file: $filePath");

	return $content;
}

function xmlToDOMDocument(string $filePath): ?\DOMDocument
{
	$xmlString = \extractFileContent($filePath);

	if($xmlString === null)
		return null;

	$document = new \DOMDocument();
	$document->loadXML($xmlString);

	return $document;
}

