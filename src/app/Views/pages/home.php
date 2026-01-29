<?php echo view("components/head.html"); ?>
<body class="stc-pattern">
	<?php echo view("components/nav.html"); ?>

	<main class="stc-body playground">
		<div id="tboxes-container" class="tboxes-container">
			<template id="tpt-tbox">
				<section class="tbox" data-type="output" data-list-id=" " aria-label="Text box unit">
					<nav class="tbox-nav">
						<select class="btn when-focused tbox-slt tbox-char-format-js" title="Characters format" aria-label="Select characters format">
							<option value="2"  >Binary</option>
							<option value="10" >Decimal</option>
							<option value="16" >Hexadecimal</option>
							<option value="8"  >Octal</option>
							<option value="NaN">Unicode (TEXT)</option>
						</select>
						<button class="btn when-focused tbox-btn-clone  tbox-btn" title="Clone text box"  aria-label="Clone text box">
							<svg aria-hidden="true" xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' viewBox='0 0 16 16'>
								<path fill-rule='evenodd' d='M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2'/>
							</svg>
						</button>
						<button class="btn when-focused tbox-btn-copy   tbox-btn" title="Copy content"    aria-label="Copy content">
							<svg aria-hidden="true" xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' viewBox='0 0 16 16'>
								<path fill-rule='evenodd' d='M4 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 5a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1v-1h1v1a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h1v1z'/>
							</svg>
						</button>
						<button class="btn when-focused tbox-btn-delete tbox-btn" title="Delete text box" aria-label="Delete text box">
							<svg aria-hidden="true" xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' viewBox='0 0 16 16'>
								<path d='M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5'/>
							</svg>
						</button>
					</nav>
					<textarea class="notranslate tbox-input" translate="off" placeholder="Result from past cell." tabindex="-1" readonly="readonly" aria-live="off"></textarea>
				</section>
			</template>
		</div>

		<script src="./templates/tbox/dom.js"></script>
		<script>newTBox();newTBox();</script>

		<aside class="aside">
			<div id="tboxes-aside" class="aside-tboxes-man">
			</div>
		</aside>
	</main>

	<?php echo view("components/footer.html"); ?>

	<div id="global-notif-container" class="global-notif-container"></div>
	<script src="./templates/notif/dom.js"></script>

	<script src="./events/core.js"></script>
	<script src="./events/generic.js"></script>
</body>
</html>
