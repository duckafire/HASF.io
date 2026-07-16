#!/usr/bin/env sh

set -euo pipefail
. /dp/export-deploy-env-variables

SCSS_FILES=""
FILES_TO_REMOVE=""

# List Files
lf()
{
	dir="$1"
	ext="$2"

	files="$(find "$dir" -name "*.$ext" -type f)"

	# Remove files that are in directories
	# that must to be ignored.
	for dir in "fallback images .lib"
	do
		# (^|\S*/)dir/\S*
		files="$(echo "$files" | sed 's/\(^\|\S*\/\)'"$dir"'\/\S*//g')"
	done

	echo "$files"
}

for file in $(lf "$HASF_IO_BUILD_PUBLIC_DIR" "scss")
do
	# Space-separated lists:
	SCSS_FILES="$SCSS_FILES $file:${file%.*}.css"
	FILES_TO_REMOVE="$FILES_TO_REMOVE $file"
done

if [ -n "$SCSS_FILES" ]
then
	SCSS_PARTIAL_SS_DIR="$HASF_IO_BUILD_ASSETS_DIR/.lib/sass"

	mkdir -p "$SCSS_PARTIAL_SS_DIR"

	SASS_OPTIONS=$(cat <<- EOF
		--no-color
		--no-unicode
		--no-error-css

		--stop-on-error
		--update
		--verbose

		--style compressed
		--load-path "$SCSS_PARTIAL_SS_DIR"
	EOF
	)

	# This compressing is minimal.
	bun x --silent sass $SASS_OPTIONS -- $SCSS_FILES
fi

rm -rf "$FILES_TO_REMOVE" "$(ls -a "$HASF_IO_BUILD_ASSETS_DIR" | grep -E '^\.[^.]+')"

