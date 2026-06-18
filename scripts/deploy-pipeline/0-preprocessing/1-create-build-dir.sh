#!/usr/bin/env sh

set -euo pipefail
. /dp/export-deploy-env-variables

cp -r "$HASF_IO_BUILD_WIP_DIR" "$HASF_IO_BUILD_ROOT_DIR"

