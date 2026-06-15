#!/usr/bin/env sh

set -euo pipefail

DATA='https://raw.githubusercontent.com/duckafire/duckafire/82215077c9a2bf7a9c52e59f96b7da1349e7ba3f/mybin/tp#536b193ba9672a1f7c941308eeed15b46d411d9d7a58f0cd1280e272341024ec'

mkdir -p "$MYBIN_DIR"
cd "$MYBIN_DIR"

for data in $DATA
do
	url="${data%#*}"
	expectedHashCode="${data#*#}"

	execFileName="${url##*/}"

	if ! wget -q "$url"
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

