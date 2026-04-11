<?php

declare(strict_types=1);

$defTemplates = \default_templates();

?>
<?= $defTemplates["head"]; ?>
<body class="page-content">
	<?= $defTemplates["nav"]; ?>

	<main class="page-main">
		<?php
			$fileName    = \READONLY_PATH."licenses/data.json";
			$dataContent = \file_get_contents($fileName);

			if($dataContent === false)
				throw new \HTTPCode500Exception("alert", "Impossible to read file: $fileName");

			$data = \json_decode($dataContent, true);

			if($data === null)
				throw new \HTTPCode500Exception("alert", "Impossible to decode JSON file: $fileName");

			$fileName    = \READONLY_PATH."licenses/texts.yaml";
			$yamlContent = \file_get_contents($fileName);

			if($yamlContent === false)
				throw new \HTTPCode500Exception("alert", "Impossible to read YAML file: $fileName");

			try
			{
				$licenses = \Symfony\Component\Yaml\Yaml::parse($yamlContent);
			}
			catch(\Symfony\Component\Yaml\Exception\ParseException $ex)
			{
				throw new \HTTPCode500Exception("alert", "Impossible to parse YAML file: $fileName");
			}

			// JSON separates them to
			// improve its legibility.
			$allData = [
				[$data["project"]],
				$data["vendor"],
			];

			foreach($allData as &$curData)
			{
				foreach($curData as &$dep)
				{
					$name         = $dep[0];
					$version      = "v{$dep[1]}";
					$licenseAlias = $dep[2];
					$licenseName  = $dep[3];
					$webSiteURL   = "https://{$dep[4]}";
					$licenseText  = $licenses[$licenseAlias];

					echo "<details><summary>$name | $version | $licenseName</summary><a href=\"$webSiteURL\">Visit it</a><p>$licenseText</p></details>";
				}
			}
		?>
	</main>

	<?= $defTemplates["footer"]; ?>
</body>
</html>

