#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname "$0")
TARGET_DIR="$SCRIPT_DIR/../.."

FILES=$(find "$SCRIPT_DIR/Papirus" "$SCRIPT_DIR/Papirus-Dark" \
	-name '*.svg' -print)

for file in $FILES; do
	src_dir=$(dirname "$file")
	top_dir=$(dirname "$src_dir")
	base_name=$(basename --suffix=".svg" "$file")

	base_dir=$(basename "$top_dir")
	context=$(basename "$src_dir")
	filename="${base_name%%@*}"
	size="${base_name##*@}"

	cp --no-preserve=mode,ownership -v "$file" \
		"$TARGET_DIR/$base_dir/$size/$context/$filename.svg"
done
