#!/usr/bin/env bash
#
# This script copies icons from the directory to the main theme

set -eo pipefail

readonly SCRIPT_DIR="$(dirname "$0")"
readonly ROOT_DIR="$SCRIPT_DIR/../.."
declare -a THEMES=(
	$(find "$ROOT_DIR" -type f -name 'index.theme' -exec dirname '{}' \;)
)

find "${THEMES[@]/$ROOT_DIR/$SCRIPT_DIR}" -name '*.svg' | \
	while read -r file; do
	src_dir=$(dirname "$file")
	top_dir=$(dirname "$src_dir")
	base_name=$(basename --suffix=".svg" "$file")

	base_dir=$(basename "$top_dir")
	context=$(basename "$src_dir")
	filename="${base_name%%@*}"
	size="${base_name##*@}"

	cp --no-preserve=mode,ownership --remove-destination -P -v "$file" \
		"$ROOT_DIR/$base_dir/$size/$context/$filename.svg"
done
