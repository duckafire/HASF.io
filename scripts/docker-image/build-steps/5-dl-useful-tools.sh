#!/usr/bin/env sh

set -euo pipefail

# (Main URL; fallback URL; and expected hash code.)
TOOLS_LIST='https://raw.githubusercontent.com/duckafire/duckafire/4318cef55d9b02dfceea7c36300e23ea622a0bf7/mybin/tp#https://gitlab.com/duckafire/duckafire/-/raw/main/mybin/tp?ref_type=heads#0f2971435208f133c49551b2b4b6d013f0c06cadd643ceeb81d0443c25791a95'

mkdir -p "$MYBIN_DIR"
cd "$MYBIN_DIR"

for data in $TOOLS_LIST
do
	url="${data%#*}"
	data="${data#*#}"

	fallbackURL="${data%#*}"
	expectedHashCode="${data#*#}"

	execFileName="${url##*/}"

	if ! wget -q "$url" && ! wget -q "$fallbackURL"
	then
		echo "Impossible to download \"$execFileName\"." 1>&2
		exit 1
	fi

	receivedHashCode="$(sha256sum "$execFileName")"

	if [ "$expectedHashCode" != "${receivedHashCode%% *}" ]
	then
		echo "Invalid executable; (CAUTION) different hash codes!" 1>&2
		exit 1
	fi

	chmod 555 "$execFileName"
done

