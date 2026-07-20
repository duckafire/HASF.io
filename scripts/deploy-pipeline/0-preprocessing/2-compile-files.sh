#!/usr/bin/env sh

set -euo pipefail
. /dp/export-deploy-env-variables

MODULES_DIR="$HASF_IO_BUILD_ASSETS_DIR/.modules"
SRC_DIRS_LIST="$HASF_IO_BUILD_ASSETS_DIR/pages $HASF_IO_BUILD_ASSETS_DIR/components"

SCSS_PARTIAL_MODULES_DIR="$MODULES_DIR/styles"
TS_MODULES_ROOT_DIR="$MODULES_DIR/behaviors/mts"
TS_MODULES_OUT_DIR="$MODULES_DIR/behaviors/mjs"

SASS_OPTIONS=$(cat <<- EOF
	--no-color
	--no-unicode
	--no-error-css

	--stop-on-error
	--update
	--verbose

	--style compressed
	--load-path "$SCSS_PARTIAL_MODULES_DIR"
EOF
)

TS_OPTIONS=$(cat <<- EOF
	--target ES6
	--module NodeNext
	--moduleResolution NodeNext
	--lib ES6,DOM,DOM.Iterable

	--outDir "$TS_MODULES_OUT_DIR"
	--rootDir "$TS_MODULES_ROOT_DIR"

	--strict true

	--noImplicitReturns true
	--noUnusedLocals true
	--noUnusedParameters true
	--noImplicitOverride true
	--noPropertyAccessFromIndexSignature true
	--noUncheckedIndexedAccess true
	--exactOptionalPropertyTypes true
	--forceConsistentCasingInFileNames true
	--isolatedModules true
	--esModuleInterop true

	--allowUnreachableCode false
	--allowUnusedLabels false
EOF
)

# (Source map only must be available
# into development environment.)
if [ -z "$HASF_IO_PRODUCTION" ]
then
	SASS_OPTIONS="$SASS_OPTIONS --source-map"
	TS_OPTIONS="$TS_OPTIONS --source-map true"
fi

sourceFiles=""

catchFiles()
{
	ext="$1"

	caughtFiles=""
	outputFiles=""

	for srcDir in $SRC_DIRS_LIST
	do
		if [ -d "$srcDir" ]
		then
			caughtFiles="$caughtFiles $(find "$srcDir" -name "*.$ext" -type f)"
			sourceFiles="$sourceFiles $caughtFiles"
		fi
	done

	if [ "$ext" = "scss" ]
	then
		for file in $caughtFiles
		do
			# input0:output0 ... inputN:outputN
			outputFiles="$outputFiles $file:${file%.*}.${ext#?}"
		done
	fi

	echo "$outputFiles"
}

scssFiles="$(catchFiles "scss")"
tsFiles="$(  catchFiles "mts" )"

if [ -n "$scssFiles" ] && [ -d "$SCSS_PARTIAL_MODULES_DIR" ]
then
	# (Minimal compression.)
	bun x --silent sass $SASS_OPTIONS -- $scssFiles
fi

if [ -n "$tsFiles" ] && [ -d "$TS_MODULES_ROOT_DIR" ]
then
	bun x --silent tsc $TS_OPTIONS -- $tsFiles
fi

# (Source map only must be available
# into development environment.)
if [ -n "$HASF_IO_PRODUCTION" ]
then
	rm -rf $sourceFiles "$MODULES_DIR"
fi

