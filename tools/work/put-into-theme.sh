#!/usr/bin/env bash
#
# This script copies icons from the directory to the main theme

set -eo pipefail

readonly SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
readonly TARGET_DIR="$SCRIPT_DIR/../.."

mapfile -t SOURCE_DIRS < <(
	find "$TARGET_DIR" -type f -name 'index.theme' -printf '%h\n' |
		while read -r target_dir; do
			[ -d "${target_dir/$TARGET_DIR/$SCRIPT_DIR}" ] || continue
			echo "${target_dir/$TARGET_DIR/$SCRIPT_DIR}"
	done
)

find "${SOURCE_DIRS[@]}" -name '*.svg' | while read -r file; do
	src_dir=$(dirname "$file")
	top_dir=$(dirname "$src_dir")
	base_name=$(basename "$file" .svg)

	base_dir=$(basename "$top_dir")
	context=$(basename "$src_dir")
	filename="${base_name%%@*}"
	size="${base_name##*@}"

	cp --no-preserve=mode,ownership --remove-destination -P -v "$file" \
		"$TARGET_DIR/$base_dir/$size/$context/$filename.svg"
done
