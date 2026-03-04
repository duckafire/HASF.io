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
	function inc_icon(?string $name = null, ?SVGIconOrigin $origin = SVGIconOrigin::LUCIDE): string
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

		return "<i class='svg-icon' aria-hidden='true'>$content</i>";
	}
}

if(!function_exists("inc_attr_titles"))
{
	function inc_attr_titles(string $text): string
	{
		return "title='$text' aria-label='$text'";
	}
}

if(!function_exists("set_no_translate"))
{
	function set_no_translate(?string $classes = ""): string
	{
		return "translate='off' class='notranslate $classes'";
	}
}

if(!function_exists("inc_btn"))
{
	function inc_btn(string $classes, string | array $icon, ?string $title = null, ?string $url = null): string
	{
		$allTitles = ($title == null ? "" : "title='$title' aria-label='$title'");

		$icon = "";

		if($icon != null)
		{
			if(\gettype($icon) == "string")
				$icon = inc_icon( $icon );
			else
				$icon = inc_icon(icon[0], icon[1]);
		}

		return ($url == null
			? "<button          class='$classes' $allTitles>"
			: "<a role='button' class='$classes' $allTitles href='$url'>") .
			$icon .
			($url == null ? "</button>" : "</a>");
	}
}

if(!function_exists("inc_slt_opt"))
{
	function inc_slt_opt(string $textContent, string $value, bool $isSelected = false): string
	{
		return "<option value='$value'".($isSelected ? "selected='selected'" : "").">$textContent</option>";
	}
}

if(!function_exists("inc_asset"))
{
	function inc_asset(string $path, string $name, string $ext): string
	{
		static $filePath = WRITEPATH."/custom/files-hash.kv";
		static $data = null;

		$fullFilePath   = "$path/$name.$ext";
		$clientFilePath = "./assets/$fullFilePath";
		$serverFilePath = FCPATH."$clientFilePath";

		if($data === null)
		{
			if(!create_file($filePath))
				return $clientFilePath;

			$data = kv_decore( $filePath );

			if($data === null)
				return $clientFilePath;
		}

		if(!isset($data[ $serverFilePath ])
		{
			$content = file_get_contents($serverFilePath);

			if($content === false)
			{
				log_message("warning", "Impossible get content (file): $serverFilePath";
				return $clientFilePath;
			}

			try
			{
				$hashedContent = hash("sha256", $content);
			}
			catch(ValueError $ex)
			{
				log_message("error",   "ValueError (from `hash`): {ex}", ["ex" => $ex]);
				log_message("warning", "Impossible to hash the content of (file): $serverFilePath");
				return $clientFilePath;
			}

			if(file_put_contents($hashedContent) === false)
			{
				log_message("warning", "Impossible to update (file): $serverFilePath");
				return $clientFilePath;
			}

			$data[ $serverFilePath ] = $hashedContent;
		}

		return "$clientFilePath?h={$data[ $serverFilePath ] }";
	}
}

