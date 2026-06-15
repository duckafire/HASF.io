#!/usr/bin/env sh

set -euo pipefail

BUN_DOWNLOAD_URL='https://github.com/oven-sh/bun/releases/download/bun-v1.3.14/bun-linux-x64-musl-baseline.zip'
BUN_EXPECTED_HASH_CODE='56a7d6806cf155536c0178f0ea5fbd098e684fa509ebdb4fc0a7e19fb65382dc'

BUN_ZIP_FILE_NAME="${BUN_DOWNLOAD_URL##*/}"

NPM_PACKAGES='sass@1.97.3 terser@5.45.0 clean-css-cli@5.6.3'

mkdir -p "$BUN_INSTALL"
cd "$BUN_INSTALL"

if ! wget -q "$BUN_DOWNLOAD_URL"
then
	echo "Impossible to download Bun." 1>&2
	exit 1
fi

bunReceivedHashCode="$(sha256sum "$BUN_ZIP_FILE_NAME")"
bunReceivedHashCode="${bunReceivedHashCode%% *}"

if [ "$BUN_EXPECTED_HASH_CODE" != "${bunReceivedHashCode%% *}" ]
then
	echo "Invalid zip archive; (CAUTION) different hash codes!" 1>&2
	exit 1
fi

unzip -q "$BUN_ZIP_FILE_NAME"
mv "$(find . -name bun -type f)" .
chmod 555 ./bun
rm -rf "${BUN_ZIP_FILE_NAME%.*}*"

echo "$PATH"
bun add --global --silent $NPM_PACKAGES

