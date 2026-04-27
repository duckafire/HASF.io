#!/usr/bin/env sh

# preprocessing [del_src_dir=false] [is_test=true]

set -euo pipefail

fatal_error()
{
	echo "Invalid value to $1. Expecting \"$2\"."
	echo
	exit 1
}


TRUE=0
FALSE=1
STR_TRUE="true"
STR_FALSE="false"

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
SRC_DIR="$SCRIPT_DIR/wip"
PROD_DIR="$SCRIPT_DIR/prod"
PROD_TESTS_DIR="$PROD_DIR/tests"
PROD_ASSETS_DIR="$PROD_DIR/public/assets"
PROD_ASSETS_MANIFEST_PATH="$PROD_DIR/readonly/assets-manifest.json"

if [ $# -ge 1 ]
then
	case "$1" in
		"$STR_TRUE")  DEL_SRC_DIR=$TRUE  ;;
		"$STR_FALSE") DEL_SRC_DIR=$FALSE ;;
		*) fatal_error "first argument (del_src_dir)" "false or true"
	esac
else
	DEL_SRC_DIR=$FALSE
fi

if [ $# -ge 2 ]
then
	case "$2" in
		"$STR_TRUE")  IS_TEST=$TRUE  ;;
		"$STR_FALSE") IS_TEST=$FALSE ;;
		*) fatal_error "second argument (is_test)" "false or true"
	esac
else
	IS_TEST=$TRUE
fi

if [ $# -ge 3 ]
then
	echo "Ignoring arguments >=3rd."
fi


if [ -d "$PROD_DIR" ]
then
	rm -rf "$PROD_DIR"
fi

cp -r "$SRC_DIR" "$PROD_DIR"

if [ $DEL_SRC_DIR -eq $TRUE ]
then
	rm -rf "$SRC_DIR"
fi

if [ $IS_TEST -eq $FALSE ]
then
	rm -rf "$PROD_TESTS_DIR"
fi


assetsManifestJSONContent="{"

for originalAbsFilePath in $(find "$PROD_ASSETS_DIR" -type f \( -name '*.css' -o -name '*.js' \))
do
	# /home/foo/hasf.io/wip/public/assets/js/bar.js
	# /app/wip/public/assets/js -> assets/js
	originalAbsDirPath="$(dirname "$originalAbsFilePath")"
	originalRelDirPath="assets/${originalAbsDirPath##*/public/assets/}"

	originalFileBaseName="$(basename "$originalAbsFilePath")"
	bufFileName="${originalFileBaseName%.*}"
	bufHashCode="$(sha256sum "$originalAbsFilePath" | awk '{print $1}')"
	bufExtName="${originalFileBaseName##*.}"
	hashedFileBaseName="$bufFileName.$bufHashCode.$bufExtName"

	#originalAbsFilePath (from for-loop)
	originalRelFilePath="$originalRelDirPath/$originalFileBaseName"

	hashedAbsFilePath="$originalAbsDirPath/$hashedFileBaseName"
	hashedRelFilePath="$originalRelDirPath/$hashedFileBaseName"

	assetsManifestJSONContent="$assetsManifestJSONContent\"$originalRelFilePath\":\"$hashedRelFilePath\","

	cp "$originalAbsFilePath" "$hashedAbsFilePath"
	rm "$originalAbsFilePath"
done

# Remove last comma, and close JSON.
assetsManifestJSONContent="${assetsManifestJSONContent%?}}"

echo "$assetsManifestJSONContent" > "$PROD_ASSETS_MANIFEST_PATH"

