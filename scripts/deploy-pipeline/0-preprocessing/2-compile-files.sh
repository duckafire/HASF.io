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

	find "$dir" -name "*.$ext" -type f
}

for file in $(lf "$HASF_IO_BUILD_PUBLIC_DIR" "scss")
do
	# Space-separated lists:
	SCSS_FILES="$SCSS_FILES $file:${file%.*}.css"
	FILES_TO_REMOVE="$FILES_TO_REMOVE $file"
done

if [ -n "$SCSS_FILES" ]
then
	# This compressing is minimal.
	bun x --silent sass --no-source-map --style compressed -- $SCSS_FILES
fi

rm -f "$FILES_TO_REMOVE"

