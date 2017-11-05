#!/usr/bin/env bash
#
# This script cleans and fixes SVG files using `tools/ffsvg.sh` script

set -eo pipefail

readonly SCRIPT_DIR="$(dirname "$0")"

find "$SCRIPT_DIR" -mindepth 2 -type f -name '*.svg' \
	-exec "$SCRIPT_DIR/../ffsvg.sh" '{}' \;
