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

function jsonToArray(string $filePath): ?array
{
	$content = \extractFileContent($filePath);

	if($content === null)
		return null;

	$content = \json_decode($content, true);

	if($content === null)
		\log_message("Impossible decode JSON file: $filePath");

	return $content;
}

function parseXMLFile(string $filePath): ?\SimpleXMLElement
{
	$xmlContent = \extractFileContent($filePath);

	if($xmlContent === null)
		return null;

	try
	{
		$xmlObject = new \SimpleXMLElement($xmlContent);
	}
	catch(\Exception $ex)
	{
		\log_message("alert", "Impossible to interpreter information from XML file: $filePath");
		return null;
	}

	return $xmlObject;
}

