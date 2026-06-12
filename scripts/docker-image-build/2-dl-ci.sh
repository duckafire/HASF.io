#!/usr/bin/env sh

set -euo pipefail

composer --quiet create-project "codeigniter4/framework:$CODE_IGNITER_V" "$WIP_DIR"

