#!/usr/bin/env sh

INPUT_STYLE_FILES=""

list_files()
{
	find "$HASF_IO_BUILD_DIR" -name "*.$1" -type f
}

for scssFile in $(list_files "scss")
do
	INPUT_STYLE_FILES="$INPUT_STYPE_FILES $scssFile:${scssFile%.*}.css"
done

if [ -n "$INPUT_STYLE_FILES" ]
then
	bun x --silent --no-lockfile sass --style=compressed $INPUT_STYLE_FILES
fi

