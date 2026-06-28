#!/usr/bin/env sh

if [ -z "$HASF_IO_PRODUCTION" ]
then
	exit
fi

set -euo pipefail
. /dp/export-deploy-env-variables

# List Files
# (Code from `/dp/0/2*`.)
lf()
{
	dir="$1"
	ext="$2"

	files="$(find "$dir" -name "*.$ext" -type f)"

	# Remove files that are in directories
	# that must to be ignored.
	for dir in "fallback images"
	do
		# (^|\S*/)dir/\S*
		files="$(echo "$files" | sed 's/\(^\|\S*\/\)'"$dir"'\/\S*//g')"
	done

	echo "$files"
}

for file in $(lf "$HASF_IO_BUILD_PUBLIC_DIR" "js")
do
	# Using a subshell to ensure that the
	# file content only will be replaced
	# after its processing.
	echo "$(bun x --silent terser --compress --mangle -- "$file")" > "$file"
done

for file in $(lf "$HASF_IO_BUILD_PUBLIC_DIR" "css")
do
	# Using optimization level 2.
	#
	# Using a subshell to ensure that the
	# file content only will be replaced
	# after its processing.
	echo "$(bun x --silent cleancss -O2 -- "$file")" > "$file"
done

