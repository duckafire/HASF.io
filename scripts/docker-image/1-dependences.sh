#!/usr/bin/env sh

ARCHIVE_DIR="/archives"
APP_DIR="/app/wip"
SVG_ICONS_DIR="$APP_DIR/public/assets/images/icons"

composer create-project 'codeigniter4/framework:4.6.3' "$APP_DIR"

# Download URL; target directory; and new name
# to the target directory after move it.
# (Both they are separated with "#".)
DEP_LIST="https://github.com/lucide-icons/lucide/archive/refs/tags/v0.265.0.zip#lucide-0.265.0/icons#$SVG_ICONS_DIR/lucide-v0.265.0 https://github.com/twbs/icons/archive/refs/tags/v1.13.1.zip#icons-1.13.1/icons#$SVG_ICONS_DIR/bootstrap-v1.13.1 https://github.com/simple-icons/simple-icons/archive/refs/tags/16.14.0.zip#simple-icons-16.14.0/icon#$SVG_ICONS_DIR/simple-icons-v16.14.0 https://github.com/symfony/yaml/archive/refs/tags/v8.0.6.zip#yaml-8.0.6#$APP_DIR/app/ThirdParty/SymfonyYAML-v8.0.6"

for item in $DEP_LIST
do
	middler="${item#*#}"

	downloadURL="${item%%#*}"
	targetDir="${middler%%#*}"
	targetDirNewName="${middler#*#}"

	wget -q -P "$ARCHIVE_DIR" "$downloadURL"
	unzip -q "$ARCHIVE_DIR/$targetDir"
	mv "$ARCHIVE_DIR/$targetDir" "$targetDirNewName"
done

rm -r "$ARCHIVES_DIR"

