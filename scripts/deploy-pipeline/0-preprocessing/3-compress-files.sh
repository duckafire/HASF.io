#!/usr/bin/env sh

set -euo pipefail
. /dp/export-deploy-env-variables

# List Files
lf()
{
	dir="$1"
	ext="$2"

	find "$dir" -name "*.$ext" -type f
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

