#!/usr/bin/env sh

ASSETS_DIR="$HASF_IO_BUILD_PUBLIC_DIR/assets"

# foo bar -> ./foo ./bar
IGNORE_DIR="$(echo "fallback images/icons" | sed 's/\(^\| \)/\1.\//g')"
TARGET_EXT="css js"

MANIFEST_FILE="$HASF_IO_BUILD_READONLY_DIR/manifests/assets.json"

manifestContent="{"

# Change directories context:
cd "$(realpath "$ASSETS_DIR")"

for dir in $(find -type d)
do
	for ignore in $IGNORE_DIR
	do
		if [ "$dir" = "$ignore" ]
		then
			continue 2
		fi
	done

	for ext in $TARGET_EXT
	do
		for target in $(find "$dir" -type f -name '*.'"$ext")
		do
			targetDirAndName="${target%.*}"
			targetExt="${targetFile##*.}"

			targetHash="$(sha256sum "$target")"
			targetHash="${targetHash%% *}" # clean output trash

			hashedTarget="$targetDirAndName.$targetHash.$targetExt"

			mv "$target" "$targetDirAndName"
			manifestContent="$manifestContent\"$target\":\"$hashedTarget\","
		done
	done
done

# Remove final comma and close the JSON:
manifestContent="${manifestContent%?}}"

mkdir -p "${MANIFEST_FILE%/*}"
echo "$manifestContent" > "$MANIFEST_FILE"

