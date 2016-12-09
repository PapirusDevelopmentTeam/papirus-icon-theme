#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
TARGET_DIR="$SCRIPT_DIR/../.."

FILES=$(find "$SCRIPT_DIR/Papirus" "$SCRIPT_DIR/Papirus-Dark" \
	-name '*.svg' -print)

for file in $FILES; do
	src_dir=$(dirname "$file")
	base_dir=$(basename "$(dirname "$src_dir")")
	directory=$(basename "$src_dir")

	basename=$(basename --suffix=".svg" "$file")
	filename=${basename%%@*}
	suffix="${basename##*@}"

	cp --no-preserve=mode,ownership -vi "$file" \
		"$TARGET_DIR/$base_dir/$suffix/$directory/$filename.svg"
done
