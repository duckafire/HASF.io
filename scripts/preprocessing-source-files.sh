#!/usr/bin/env sh

# Get full path of an asset:
#   /foo/bar/prod/wip/public/assets/foo.bar
#
# Get relative path of that file:
#   ./wip/public/assets/foo.bar
#
# Digest its content using sha256sum:
#   4ed7e4005933675db2a285b9c42ee50bcd535cc4d936a32a42bd3927819a6d18
#
# Rename it and include the digested string:
#   ./wip/public/assets/foo.4ed7e4005933675db2a285b9c42ee50bcd535cc4d936a32a42bd3927819a6d18.bar
#
# (After to do this with ALL non-ignored assets)
# create a manifest file (JSON), to allow that
# the PHP can find the renamed files.

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
WIP_ASSETS_DIR="$SCRIPT_DIR/wip/public/assets"
PROD_ASSETS_DIR="$SCRIPT_DIR/prod/public/assets"
MANIFEST_FILE_PATH="$SCRIPT_DIR/prod/readonly/manifests/assets.json"

IGNORE_DIR=$(cat <<- EOF
$WIP_ASSETS_DIR/images/icons
$WIP_ASSETS_DIR/fallback
EOF
)

# Start JSON object:
manifestFileContent="{"

for dir in $(find "$WIP_ASSETS_DIR" -type d)
do
	for ignore in $(ls "$dir")
	do
		if [ "$dir" = "$ignore" ]
		then
			continue 2
		fi
	done

	for fileName in $(ls -p "$dir" | grep -v /)
	do
		path="${fileName%/*}"
		path="${path#$WIP_ASSETS_DIR/}"

		name="${fileName##*/}"
		ext="${fileName##*.}"

		code="$(sha256sum "$fileName" | awk '{print $1}')"

		newFileName="$PROD_ASSETS_DIR/$path/$name.$code.$ext"

		mv "$fileName" "$newFileName"
		manifestFileContent="$manifestFileContent\"$fileName\":\"$newFileName\";"
	done
done

# Remove last semi-colon of the JSON
# object and close it:
manifestFileContent="${manifestFileContent%?}}"

echo "$manifestFileContent" > "$MANIFEST_FILE_NAME"
