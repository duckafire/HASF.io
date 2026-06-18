#!/usr/bin/env sh

set -euo pipefail

ASSETS_DIR="$WIP_DIR/public/assets"
ICONS_DIR="$ASSETS_DIR/images/icons"
PHP_LIBS_DIR="$WIP_DIR/app/ThirdParty/"

# Download URL;
# integrity hash code;
# target subdirectory; and
# new name to target:
ICONS_PACKAGES='
https://github.com/lucide-icons/lucide/archive/refs/tags/v0.265.0.zip#97dd81cb89ca9a4361572cda1eca5b7b54d45cf191cf209d93f7466d9dd7c873#icons#lucide-v0.265.0
https://github.com/twbs/icons/archive/refs/tags/v1.13.1.zip#5306b822b5283a66aa194c48185010ee1905cf593b7b5009f5adef826f41d60f#icons#bootstrap-v1.13.1
https://github.com/simple-icons/simple-icons/archive/refs/tags/16.14.0.zip#7a2e3add60b04c131ac5c30394f9610fb9a8688900c131b5b0bd99bd7882369d#icons#simple-icons-v16.14.0
'

PHP_LIBS='
https://github.com/symfony/yaml/archive/refs/tags/v8.0.6.zip#c177f20d62321075c984e9890b71b5055f44be50cb12a84976c2c7262cde3740#.#SymfonyYAML-v8.0.6
'

processData()
{
	dir="$1"

	mkdir -p "$dir"
	cd "$dir"

	shift

	for data in $@
	do
		url="${data%%#*}"
		data="${data#*#}"

		fileName="${url#*.com/}"
		fileName="${fileName%%/*}"

		expectedHashCode="${data%%#*}"
		data="${data#*#}"

		# Directory name + target name:
		targetDir="${fileName%%.*}/${data%%#*}"

		targetDirNewName="${data#*#}"

		if ! wget -qO "$fileName" "$url"
		then
			echo "Impossible to download "$fileName"." 1>&2
			exit 1
		fi

		receivedHashCode="$(sha256sum "$fileName")"

		if [ "$expectedHashCode" != "${receivedHashCode%% *}" ]
		then
			echo "Invalid zip archive; (CAUTION) different hash codes!" 1>&2
			exit 1
		fi

		test "${fileName#*.}" != "zip" && continue

		if ! unzip -q "$fileName"
		then
			echo "Impossible to unzip \"$fileName\"." 1>&2
			exit 1
		fi

		mv "$targetDir" "$targetDirNewName"
		rm -rf "$fileName" "${fileName#*.zip}"
	done
}

processData "$ICONS_DIR"    $ICONS_PACKAGES
processData "$PHP_LIBS_DIR" $PHP_LIBS

# Remove icons metadata:
rm -f $(find "$ICONS_DIR" -name '*.json' -type f)

