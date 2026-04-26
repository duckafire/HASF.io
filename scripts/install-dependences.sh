#!/usr/bin/env sh

ARCHIVES_DIR="/archives"
DEPENDENCES_DIR="/dependences"

DOWNLOAD_URLS='https://github.com/lucide-icons/lucide/archive/refs/tags/v0.265.0.zip
https://github.com/twbs/icons/archive/refs/tags/v1.13.1.zip
https://github.com/simple-icons/simple-icons/archive/refs/tags/16.14.0.zip
https://github.com/symfony/yaml/archive/refs/tags/v8.0.6.zip'

# Extracted directory name (origin): dependences alias (destine)
MAP_DEPENDENCES_NAMES='lucide-0.265.0/icons lucide-v0.265.0
icons-1.13.1/icons bootstrap-v1.13.1
simple-icons-16.14.0/icons simple-icons-v16.14.0
yaml-8.0.6 SymfonyYAML-v8.0.6'

mkdir "$ARCHIVES_DIR" "$DEPENDENCES_DIR"

for url in $DOWNLOAD_URLS
do
	wget -q -P "$ARCHIVES_DIR" "$url"
done

for archive in $(ls "$ARCHIVES_DIR")
do
	unzip -q "$archive"
done

origin=""
destine=""
for directory in $MAP_DEPENDENCES_NAMES
do
	if [ -z "$origin" ]
	then
		origin="$directory"
		continue
	fi

	if [ -z "$destine" ]
	then
		destine="$DEPENDENCES_DIR/$directory"
		continue
	fi

	mv "$origin" "$destine"
	origin=""
	destine=""
done

