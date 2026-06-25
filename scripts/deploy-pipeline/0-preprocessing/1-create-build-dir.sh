#!/usr/bin/env sh

set -euo pipefail
. /dp/export-deploy-env-variables

templatesToProcess="$(cat << EOF
$HASF_IO_BUILD_ROOT_DIR/../.htaccess
$HASF_IO_BUILD_ROOT_DIR/../index.php
EOF
)"

cp -r "$HASF_IO_BUILD_WIP_DIR" "$HASF_IO_BUILD_ROOT_DIR"

uriRoot="$(echo "${HASF_IO_BUILD_ROOT_DIR#${HASF_IO_WORK_DIR}}" | sed 's/\//\\\//g' | sed 's/^\\\///g')"

for file in $templatesToProcess
do
	echo "$(tp "$file" "URI_ROOT=$uriRoot")" > "$file"
done

