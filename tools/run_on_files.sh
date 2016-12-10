#!/usr/bin/env bash
#
# usage:
#  ./run_on_files.sh FILE...

SCRIPT_DIR=$(dirname "$0")

for file in "$@"; do
	# continue if exist
	[ -e "$file" ] || continue

	# continue if not symlink
	[ ! -L "$file" ] || continue

	# continue if extension = svg
	[ "${file##*.}" == "svg" ] || continue

	echo "=> Workon '$file' ..." >&2

	# optimize
	svgo --config="$SCRIPT_DIR/svgo.yml" -i "$file"

	# fix color scheme
	eval "$SCRIPT_DIR/_fix_color_scheme.sh"	"$file"

	# clear a style attribute
	eval "$SCRIPT_DIR/_clean_style_attr.sh"	"$file"
done
