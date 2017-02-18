#!/usr/bin/env bash

set -eo pipefail

SCRIPT_DIR=$(dirname "$0")
_PAPIRUS_DIR="$SCRIPT_DIR/Papirus"
_PAPIRUS_DARK_DIR="$SCRIPT_DIR/Papirus-Dark"

# copy file from Papirus to Papirus-Dark
for dir in "$_PAPIRUS_DARK_DIR"/*; do
	subdir=$(basename "$dir")

	case "$subdir" in
		actions)
			find "$_PAPIRUS_DIR/$subdir" \
				-name '*@16x16.svg' -print0 -o \
				-name '*@22x22.svg' -print0 -o \
				-name '*@24x24.svg' -print0 | xargs -0 -i \
					cp -auv '{}' "$_PAPIRUS_DARK_DIR/$subdir"
			;;
		devices|places)
			find "$_PAPIRUS_DIR/$subdir" \
				-name '*@16x16.svg' -print0 | xargs -0 -i \
					cp -auv '{}' "$_PAPIRUS_DARK_DIR/$subdir"
			;;
		panel)
			find "$_PAPIRUS_DIR/$subdir" \
				-name '*@22x22.svg' -print0 -o \
				-name '*@24x24.svg' -print0 | xargs -0 -i \
					cp -auv '{}' "$_PAPIRUS_DARK_DIR/$subdir"
			;;
		*)
			continue
			;;
	esac
done

# convert color scheme
find "$_PAPIRUS_DARK_DIR" -type f -name '*.svg' -exec sed -i \
	-e 's/#5c616c/#d3dae3/I' '{}' \;
