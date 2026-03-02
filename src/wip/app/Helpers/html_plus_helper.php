<?php

declare(strict_types=1);

use App\Libraries\KeyValue;

if(!enum_exists("SVGIconOrigin"))
{
	enum SVGIconOrigin
	{
		case LUCIDE;
		case BOOTSTRAP;
	}
}

if(!function_exists("inc_icon"))
{
	function inc_icon(?string $name = null, ?SVGIconOrigin $origin = SVGIconOrigin::LUCIDE): void
	{
		$dir = match($origin)
		{
			SVGIconOrigin::LUCIDE    => "lucide-v0.265.0",
			SVGIconOrigin::BOOTSTRAP => "bootstrap-v1.13.1",
		};

		try {
			$content = \file_get_contents("../public/assets/images/icons/$dir/$name.svg");

		} catch(\Throwable $ex) {
			$content = false;
		}

		if(!$content) // Replacement Character
			$content = "&#xfffd;";

		echo "<i class='svg-icon' aria-hidden='true'>$content</i>";
	}
}

if(!function_exists("inc_attr_titles"))
{
	function inc_attr_titles(string $text): void
	{
		echo "title='$text' aria-label='$text'";
	}
}

if(!function_exists("set_no_translate"))
{
	function set_no_translate(?string $classes = ""): void
	{
		echo "translate='off' class='notranslate $classes'";
	}
}

if(!function_exists("inc_btn"))
{
	function inc_btn(string $classes, string | array $icon, ?string $title = null, ?string $url = null): void
	{
		$allTitles = ($title == null ? "" : "title='$title' aria-label='$title'");

		echo ($url == null
			? "<button          class='$classes' $allTitles>"
			: "<a role='button' class='$classes' $allTitles href='$url'>");

		if($icon != null)
		{
			if(\gettype($icon) == "string")
				inc_icon( $icon );
			else
				inc_icon(icon[0], icon[1]);
		}

		echo ($url == null ? "</button>" : "</a>");
	}
}

if(!function_exists("inc_slt_opt"))
{
	function inc_slt_opt(string $textContent, string $value, bool $isSelected = false): void
	{
		echo "<option value='$value'".($isSelected ? "selected='selected'" : "").">$textContent</option>";
	}
}

if(!function_exists("inc_asset"))
{
	function inc_asset(string $path, string $name, string $ext): void
	{
		static $filePath = WRITEPATH."/custom/files-hash.kv";
		static $data = null;

		$fullFilePath   = "$path/$name.$ext";
		$clientFilePath = "./assets/$fullFilePath";
		$serverFilePath = FCPATH."$clientFilePath";

		if($data === null)
		{
			if(!create_file($filePath))
			{
				echo $clientFilePath;
				return;
			}

			$data = kv_decore( $filePath );

			if($data === null)
			{
				echo $clientFilePath;
				return;
			}
		}

		if(!isset($data[ $serverFilePath ])
		{
			$content = file_get_contents($serverFilePath);

			if($content === false)
			{
				log_message("warning", "Impossible get content (file): $serverFilePath";
				echo $clientFilePath;
				return;
			}

			try
			{
				$hashedContent = hash("sha256", $content);
			}
			catch(ValueError $ex)
			{
				log_message("error",   "ValueError (from `hash`): {ex}", ["ex" => $ex]);
				log_message("warning", "Impossible to hash the content of (file): $serverFilePath");
				echo $clientFilePath;
				return;
			}

			if(file_put_contents($hashedContent) === false)
			{
				log_message("warning", "Impossible to update (file): $serverFilePath");
				echo $clientFilePath;
				return;
			}

			$data[ $serverFilePath ] = $hashedContent;
		}

		echo "$clientFilePath?h={$data[ $serverFilePath ] }";
	}
}

