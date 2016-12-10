#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname "$0")
_PAPIRUS_DIR="$SCRIPT_DIR/Papirus"
_PAPIRUS_DARK_DIR="$SCRIPT_DIR/Papirus-Dark"

# copy file from Papirus to Papirus-Dark
for dir in "$_PAPIRUS_DARK_DIR"/*; do
	dir_name=$(basename "$dir")
	files=$(find "$_PAPIRUS_DIR/$dir_name" -name '*.svg' -print)

	for file in $files; do
		cp -auv "$file" "$_PAPIRUS_DARK_DIR/$dir_name"
	done
done

# convert color scheme
find "$_PAPIRUS_DARK_DIR" -type f -name '*.svg' -exec sed -i \
	-e 's/#5c616c/#d3dae3/I' '{}' \;
