<?php

declare(strict_types=1);

$defTemplates = \default_templates(["head" => ["head_tags" => ["intern" => ["css" => ["pages/licenses"]]]]]);

?>
<?= $defTemplates["head"]; ?>
<body class="page-content">
	<?= $defTemplates["nav"]; ?>

	<main class="page-main">
		<?php
			$data     = \jsonToArray(\READONLY_PATH."licenses/metadata.json");
			$licenses = \parseXMLFile(\READONLY_PATH."licenses/texts.xml");

			if($data === null || $licenses === null)
				throw new \HTTPCode500Exception();

			$allData       = [ [$data["project"]], $data["vendor"], ];
			$licCopSniOpen = "<span class=\"vendor-copyright-snippet\">";
			$spanClose     = "</span>";

			echo "<ul class=\"vendors-list\">";

			foreach($allData as &$curData)
			{
				foreach($curData as &$dep)
				{
					$name         = "$licCopSniOpen{$dep[0]}$spanClose";
					$version      = "{$licCopSniOpen}v{$dep[1]}$spanClose";
					$licenseAlias = $dep[2];
					$licenseName  = "$licCopSniOpen{$dep[3]}$spanClose";
					$webSiteURL   = "https://{$dep[4]}";
					$licenseText  = $licenses->{$licenseAlias}->div->asXML();

					?>
						<li>
							<details class="vendor-license-container">
								<summary class="vendor-copyright"><?= $name, $version, $licenseName; ?></summary>
								<a class="licenses-link" href="<?= $webSiteURL; ?>">Visit it</a>
								<?= $licenseText; ?>
							</details>
						</li>
					<?php
				}
			}

			echo "</ul>";
		?>
	</main>

	<?= $defTemplates["footer"]; ?>
</body>
</html>

