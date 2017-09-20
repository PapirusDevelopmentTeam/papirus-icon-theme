#!/usr/bin/env bash
#
# This script copies icons from the directory to the main theme

set -eo pipefail

SCRIPT_DIR="$(dirname "$0")"
TARGET_DIR="$SCRIPT_DIR/../.."
SOURCE_DIRS=(
	"$SCRIPT_DIR/ePapirus"
	"$SCRIPT_DIR/Papirus"
	"$SCRIPT_DIR/Papirus-Adapta"
	"$SCRIPT_DIR/Papirus-Adapta-Nokto"
	"$SCRIPT_DIR/Papirus-Dark"
	"$SCRIPT_DIR/Papirus-Light"
)

find "${SOURCE_DIRS[@]}" -name '*.svg' | while read -r file; do
	src_dir=$(dirname "$file")
	top_dir=$(dirname "$src_dir")
	base_name=$(basename --suffix=".svg" "$file")

	base_dir=$(basename "$top_dir")
	context=$(basename "$src_dir")
	filename="${base_name%%@*}"
	size="${base_name##*@}"

	cp --no-preserve=mode,ownership --remove-destination -P -v "$file" \
		"$TARGET_DIR/$base_dir/$size/$context/$filename.svg"
done
