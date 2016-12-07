#!/usr/bin/env bash
#
# usage:
#  ./run_on_files.sh FILE...

for file in "$@"; do
	# continue if exist
	[ -e "$file" ] || continue

	# continue if not symlink
	[ ! -L "$file" ] || continue

	# continue if extension = svg
	[ "${file##*.}" == "svg" ] || continue

	echo "=> Workon '$file' ..." >&2

	# optimize
	svgo --config="svgo.yml" -i "$file"

	# fix
	eval "_fix_color_scheme.sh"	"$file"
done
