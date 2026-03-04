<?= view("components/head", [
	"head_tags" => [
		"intern" => [
			"css" => [
				"css/home",
			],
		],
	],
]); ?>

<body class="page-content">
	<?= view("components/nav"); ?>

	<main class="page-main">
		<ul class="tbox-list">

			<li class="tbox" data-type="input">
				<div class="slt-container tbox-tmode-container">
					<select class="tbox-tmode">
						<?=
							inc_slt_opt("Binary",         "2"),
							inc_slt_opt("Octal",          "8"),
							inc_slt_opt("Decimal",        "10"),
							inc_slt_opt("Hexadecimal",    "16"),
							inc_slt_opt("Unicode (TEXT)", "0", true);
						?>
					</select>
				</div>
				<div class="tbox-ctt">
					<textarea <?= set_no_translate("tbox-txt"); ?> placeholder="Insert the text here..."></textarea>
					<aside class="tbox-opts">
						<?=
							inc_btn("tbox-btn", "x",         "Delete written content"),
							inc_btn("tbox-btn", "clipboard", "Copy written contetn to clipboard"),
							inc_btn("tbox-btn", "play",      "Run converting process");
						?>
					</aside>
				</div>
			</li>

			<li class="tbox" data-type="output">
				<div class="slt-container tbox-tmode-container">
					<select class="tbox-tmode">
						<?=
							inc_slt_opt("Binary",         "2"),
							inc_slt_opt("Octal",          "8"),
							inc_slt_opt("Decimal",        "10", true),
							inc_slt_opt("Hexadecimal",    "16"),
							inc_slt_opt("Unicode (TEXT)", "0");
						?>
					</select>
				</div>
				<div class="tbox-ctt">
					<pre <?= set_no_translate("tbox-txt"); ?> placeholder="Output from last text box..." readonly="readonly"></pre>
					<aside class="tbox-opts">
						<?=
							inc_btn("tbox-btn", "x",         "Delete written content"),
							inc_btn("tbox-btn", "clipboard", "Copy written contetn to clipboard"),
							inc_btn("tbox-btn", "copy",      "Copy text box"),
							inc_btn("tbox-btn", "trash-2",   "Delete text box");
						?>
					</aside>
				</div>
			</li>

		</ul>
	</main>

	<?= view("components/footer"); ?>

	<script src="./assets/js/tboxes/core.js"></script>
</body>
</html>

