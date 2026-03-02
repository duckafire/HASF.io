<?php

declare(strict_types=1);

function create_file(string $filePath): bool
{
	$dirPath = \dirname( $filePath );

	if(!\is_dir($dirPath) && !\mkdir($dirPath))
	{
		log_message("warning", "Impossible to create (directory): $dirPath");
		return false;
	}

	if(!\is_file($filePath))
	{
		$file = \fopen( $filePath, "w" );

		if(!$file)
		{
			log_message("warning", "Impossible to create (file): $filePath");
			return false;
		}

		if(!(\fclose($file))
		{
			log_message("warning", "Impossible to close (file): $filePath");

			if(!\unlink($filePath))
				log_message("warning", "Impossible to delete (file): $filePath");

			return false;
		}
	}

	return true;
}

