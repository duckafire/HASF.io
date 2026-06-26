#!/usr/bin/env sh

set -eo pipefail
. /dp/export-deploy-env-variables

MANIFEST_PATH="$HASF_IO_BUILD_MANIFESTS_DIR/assets.json"

manifestContent="{"

# It will easily things, because all
# relative path of assets are from
# assets directory.
mkdir -p "$HASF_IO_BUILD_ASSETS_DIR"
cd "$HASF_IO_BUILD_ASSETS_DIR"

# (List files; remove path prefix; and
# remove files that are inside directories
# that must be ignored.)
for filePath in $(find . -type f | sed 's/^\.\///g' | grep -vE "^(fallback|images/icons)/")
do
	fileDir="${filePath%/*}"
	fileName="${filePath##*/}"

	fileOnlyName="${fileName%.*}"
	fileExt="${fileName##*.}"

	hashCode="$(xxh128sum "$filePath")"
	hashCode="${hashCode%% *}"

	if [ -n "$HASF_IO_PRODUCTION" ]
	then
		# (This reduces manifest size, what
		# reduces a few memory consume.)
		hashedFilePath="$fileDir/$hashCode.$fileExt"
	else
		# (More plain information helps debugging.)
		hashedFilePath="$fileDir/$fileOnlyName.$hashCode.$fileExt"
	fi

	manifestContent="$manifestContent\"$filePath\":\"$hashedFilePath\","

	mv "$filePath" "$hashedFilePath"
done

# Remove last comma and close JSON.
manifestContent="${manifestContent%,}}"

mkdir -p "$HASF_IO_BUILD_MANIFESTS_DIR"
echo "$manifestContent" > "$MANIFEST_PATH"

