#!/usr/bin/env sh

## Download frameworks, libraries, ..., necessary to run this
## project.

ARCHIVES_DIR="/app/archives"
UNPACKED_ARCHIVES_DIR="$ARCHIVES_DIR/unpacked"
WIP_DIR="$WORK_DIR/wip"
SVG_ICONS_DIR="$WIP_DIR/public/assets/images/icons"

BUN_GLOBAL_PACKAGES="sass@1.97.3"

# Download URL#Repository target#Destine directory
DEP_LIST=$(cat << EOF
https://github.com/lucide-icons/lucide/archive/refs/tags/v0.265.0.zip#lucide-0.265.0/icons#$SVG_ICONS_DIR/lucide-v0.265.0
https://github.com/twbs/icons/archive/refs/tags/v1.13.1.zip#icons-1.13.1/icons#$SVG_ICONS_DIR/bootstrap-v1.13.1
https://github.com/simple-icons/simple-icons/archive/refs/tags/16.14.0.zip#simple-icons-16.14.0/icons#$SVG_ICONS_DIR/simple-icons-v16.14.0
https://github.com/symfony/yaml/archive/refs/tags/v8.0.6.zip#yaml-8.0.6#$WIP_DIR/app/ThirdParty/SymfonyYAML-v8.0.6
EOF
)

abort()
{
	echo "$1" 1>&2
	exit 1
}

unpackArchive()
{
	downloadURL="$1"
	archivePath="$2"

	archiveFormat="${downloadURL##*.}"
	archiveFormat="${archiveFormat%\?*}"

	case "$archiveFormat" in
		"zip") unzip -qd "$UNPACKED_ARCHIVES_DIR" "$archivePath" ;;
		*)     abort "Unsupported archive format: $archiveFormat" ;;
	esac

	test $? -ne 0 && abort "Impossible to unpack archive: $archivePath"
}

composer --quiet create-project 'codeigniter4/framework:4.6.3' "$WIP_DIR"

mkdir -p "$UNPACKED_ARCHIVES_DIR" "$SVG_ICONS_DIR"

for item in $DEP_LIST
do
	middler="${item#*#}"

	downloadURL="${item%%#*}"
	targetDir="${middler%#*}"
	destDir="${middler#*#}"

	archiveName="${downloadURL##*/}"
	archivePath="$ARCHIVES_DIR/$archiveName"
	targetDirPath="$UNPACKED_ARCHIVES_DIR/$targetDir"

	wget -qP "$ARCHIVES_DIR" "$downloadURL" 2>/dev/null

	test $? -ne 0 && abort "Impossible to download archive from: $downloadURL"

	unpackArchive "$downloadURL" "$archivePath"

	mkdir -p "${destDir%/*}"
	mv "$targetDirPath" "$destDir"
done

rm -r "$ARCHIVES_DIR"

bun add --global --silent $BUN_GLOBAL_PACKAGES

