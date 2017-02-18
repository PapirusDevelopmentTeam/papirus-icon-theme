#!/usr/bin/env bash

set -eo pipefail

SCRIPT_DIR=$(dirname "$0")
_PAPIRUS_DIR="$SCRIPT_DIR/Papirus"
_EPAPIRUS_DIR="$SCRIPT_DIR/ePapirus"

# copy file from Papirus to ePapirus
for dir in "$_EPAPIRUS_DIR"/*; do
	subdir=$(basename "$dir")

	case "$subdir" in
		actions)
			find "$_PAPIRUS_DIR/$subdir" \
				-name '*@16x16.svg' -print0 -o \
				-name '*@22x22.svg' -print0 -o \
				-name '*@24x24.svg' -print0 | xargs -0 -i \
					cp -auv '{}' "$_EPAPIRUS_DIR/$subdir"
			;;
		devices|places)
			find "$_PAPIRUS_DIR/$subdir" \
				-name '*@16x16.svg' -print0 | xargs -0 -i \
					cp -auv '{}' "$_EPAPIRUS_DIR/$subdir"
			;;
		panel)
			find "$_PAPIRUS_DIR/$subdir" \
				-name '*@22x22.svg' -print0 -o \
				-name '*@24x24.svg' -print0 | xargs -0 -i \
					cp -auv '{}' "$_EPAPIRUS_DIR/$subdir"
			;;
		*)
			continue
			;;
	esac
done

# convert color scheme
find "$_EPAPIRUS_DIR" -type f -name '*.svg' -exec sed -i \
	-e 's/#5c616c/#6e6e6e/I' \
	-e 's/#d3dae3/#ffffff/I' '{}' \;
