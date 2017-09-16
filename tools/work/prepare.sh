#!/usr/bin/env bash
# This script cleans and fixes SVG files using `tools/ffsvg.sh` script

set -eo pipefail

SCRIPT_DIR=$(dirname "$0")
SOURCE_DIRS=(
	"$SCRIPT_DIR/ePapirus"
	"$SCRIPT_DIR/Papirus"
	"$SCRIPT_DIR/Papirus-Adapta"
	"$SCRIPT_DIR/Papirus-Dark"
	"$SCRIPT_DIR/Papirus-Light"
)

"$SCRIPT_DIR/../ffsvg.sh" "${SOURCE_DIRS[@]}"
