#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
_PAPIRUS_DIR="$SCRIPT_DIR/Papirus"
_PAPIRUS_DARK_DIR="$SCRIPT_DIR/Papirus-Dark"

# copy file from Papirus to Papirus-Dark
for dir in "$_PAPIRUS_DARK_DIR"/*; do
	dirname=$(basename "$dir")
	files=$(find "$_PAPIRUS_DIR/$dirname" -name '*.svg' -print)

	for file in $files; do
		cp -auv "$file" "$_PAPIRUS_DARK_DIR/$dirname"
	done
done

# convert color scheme
find "$_PAPIRUS_DARK_DIR" -type f -name '*.svg' -exec sed -i \
	-e 's/color:#5c616c;/color:#d3dae3;/I' \
	-e 's/id="papirus"/id="papirus-dark"/I' '{}' \;
