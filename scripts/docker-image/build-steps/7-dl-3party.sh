#!/usr/bin/env sh

set -euo pipefail

TEMP_DIR_NAME="__temporary__"

ASSETS_DIR="$WIP_DIR/public/assets"
ICONS_DIR="$ASSETS_DIR/images/icons"
PHP_LIBS_DIR="$WIP_DIR/app/ThirdParty/"
FALLBACK_FRONT_END_DIR="$ASSETS_DIR/fallback"

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

FALLBACK_FRONT_END_LIBS='
https://code.jquery.com/jquery-3.7.1.slim.min.js
'

isZipFile()
{
	file="$1"

	# (Read first four bytes of the file;
	# format output (bytes) (do not show
	# bytes address and use hexadecimal
	# format); and remove white spaces.)
	bytes=$(head -c 4 "$file" | od -An -t x1 | tr -d '[:space:]')

	case "$bytes" in
		# Possible "magic bytes" of zip files
		# (default; empty; and split):
		"504b0304"|"504b0506"|"505b0708")
			# true
			return 0
			;;
	esac

	# false
	return 1
}

listZipArchiveContent()
{
	# Specific solution to Unzip
	# from BusyBox collection.
	#
	# (1. Ignore first tree lines;
	# 2. ignore lines that ends with "files";
	# 3. ignore lines that contains "----"; and
	# 4. print last element of each line.)
	unzip -l "$1" | awk 'NR > 3 && $NF !~ /files/ && $NF !~ /----/ {print $NF}'
}

processData()
{
	dir="$1"

	# (This TEMPORARY directory is used to
	# easily the clean of unnecessary
	# files and directories.)
	mkdir -p "$dir/$TEMP_DIR_NAME"
	cd "$dir/$TEMP_DIR_NAME"

	shift

	for data in $@
	do
		url="${data%%#*}"
		data="${data#*#}"

		fileName="${url#*.com/}"
		fileName="${fileName%%/*}"

		expectedHashCode="${data%%#*}"
		data="${data#*#}"

		targetDirNameNoPath="${data%%#*}"
		destineDir="../${data#*#}"

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

		if ! isZipFile "$fileName"
		then
			mv "$fileName" "$destineDir"
			continue
		fi

		if ! unzip -q "$fileName"
		then
			echo "Impossible to unzip \"$fileName\"." 1>&2
			exit 1
		fi
		
		zipArchiveContent="$(listZipArchiveContent "$fileName")"
		
		# Get root directory name:
		targetDirPath="${zipArchiveContent%%/*}"

		if [ "$targetDirNameNoPath" != "." ]
		then
			# (Only if it is not the root directory.)
			targetDirPath="$targetDirPath/$targetDirNameNoPath"
		fi

		mkdir -p "$destineDir"

		# (Like `ls`, but it includes the relative
		# path of the caught files.)
		find "$targetDirPath" -mindepth 1 -maxdepth 1 -exec mv {} "$destineDir" \;
		rm -rf *
	done

	cd ..
	rmdir "$TEMP_DIR_NAME"
}

processData "$ICONS_DIR"    $ICONS_PACKAGES
processData "$PHP_LIBS_DIR" $PHP_LIBS

# Remove icons metadata:
rm -f $(find "$ICONS_DIR" -name '*.json' -type f)

# (All they are just minified JavaScript files.)
mkdir -p "$FALLBACK_FRONT_END_DIR"
cd "$FALLBACK_FRONT_END_DIR"

for url in $FALLBACK_FRONT_END_LIBS
do
	if ! wget -q "$url"
	then
		echo "Impossible to download fallback front end library from: $url" 1>&2
		exit 1
	fi
done

