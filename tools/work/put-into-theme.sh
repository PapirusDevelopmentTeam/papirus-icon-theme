#!/usr/bin/env bash
#
# This script copies icons from the directory to the main theme

set -eo pipefail

readonly SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
readonly TARGET_DIR="$SCRIPT_DIR/../.."

has_symbolic_suffix() {
	case "$1" in
		*-symbolic) return 0 ;;
		*)          return 1 ;;
	esac
}

mapfile -t SOURCE_DIRS < <(
	find "$TARGET_DIR" -type f -name 'index.theme' -printf '%h\n' |
		while read -r target_dir; do
			[ -d "${target_dir/$TARGET_DIR/$SCRIPT_DIR}" ] || continue
			echo "${target_dir/$TARGET_DIR/$SCRIPT_DIR}"
	done
)

find "${SOURCE_DIRS[@]}" -name '*.svg' | while read -r file; do
	# Extract theme_dir, context_dir, icon name, and size_dir
	if [[ $file =~ .*/([^/]+)/([^/]+)/(.+)@([0-9x]+)\.svg ]]; then
		theme_dir="${BASH_REMATCH[1]}"
		context_dir="${BASH_REMATCH[2]}"
		icon_name="${BASH_REMATCH[3]}"
		size_dir="${BASH_REMATCH[4]}"
	fi

	if has_symbolic_suffix "$icon_name"; then
		context_dir="symbolic/$context_dir"
	fi

	cp --no-preserve=mode,ownership --remove-destination -P -v "$file" \
		"$TARGET_DIR/$theme_dir/$size_dir/$context_dir/$icon_name.svg"
done
