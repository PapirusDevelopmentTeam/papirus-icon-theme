#!/usr/bin/env bash

set -eo pipefail

SCRIPT_DIR=$(dirname "$0")
_PAPIRUS_DIR="$SCRIPT_DIR/Papirus"
_PAPIRUS_LIGHT_DIR="$SCRIPT_DIR/Papirus-Light"

# copy file from Papirus to Papirus-Dark
for dir in "$_PAPIRUS_LIGHT_DIR"/*; do
	subdir=$(basename "$dir")

	case "$subdir" in
		panel)
			find "$_PAPIRUS_DIR/$subdir" \
				-name '*@22x22.svg' -print0 -o \
				-name '*@24x24.svg' -print0 | xargs -0 -i \
					cp -auv '{}' "$_PAPIRUS_LIGHT_DIR/$subdir"
			;;
		*)
			continue
			;;
	esac
done

# convert color scheme
find "$_PAPIRUS_LIGHT_DIR" -type f -name '*.svg' -exec sed -i \
	-e 's/class="ColorScheme-ButtonBackground"/class="ColorScheme-Text"/I' \
	-e 's/\s*\.ColorScheme-ButtonBackground.\+\}//I' \
	-e 's/#d3dae3/#5c616c/gI' '{}' \;
