#!/usr/bin/env sh

set -euo pipefail
. /dp/export-deploy-env-variables

SRC_DIRS_LIST="$HASF_IO_BUILD_ASSETS_DIR/pages $HASF_IO_BUILD_ASSETS_DIR/components"

# (Optimization level 2.)
CLEANCSS_OPTIONS=$(cat <<- EOF
	-O2
EOF
)

ESBUILD_OPTIONS=$(cat <<- EOF
	--bundle
	--minify

	--node-paths="$HASF_IO_BUILD_ASSETS_DIR/behaviors/mjs"
EOF
)

# (Source map only must be available
# into development environment.)
if [ -z "$HASF_IO_PRODUCTION" ]
then
	CLEANCSS_OPTIONS="$CLEANCSS_OPTIONS --source-map"
	ESBUILD_OPTIONS="$ESBUILD_OPTIONS --source-map"
fi

compressFiles()
{
	bin="$1"
	options="$2"
	inExt="$3"
	outExt="$4"

	files=""

	for dir in $SRC_DIRS_LIST
	do
		if [ -d "$dir" ]
		then
			files="$(find "$dir" -name "*.$inExt" -type f)"
		fi
	done

	for file in $files
	do
		bun x --silent "$bin" $options --output="${file%.*}.min.$outExt" -- "$file"
	done

	if [ -n "$HASF_IO_PRODUCTION" ]
	then
		rm -rf $files
	fi
}

compressFiles "cleancss" "$CLEANCSS_OPTIONS" "css" "css"
compressFiles "esbuild"  "$ESBUILD_OPTIONS"  "mjs" "js"

