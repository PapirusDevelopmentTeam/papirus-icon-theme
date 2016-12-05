#!/usr/bin/env bash
#
# usage:
#  ./run_on_files.sh FILE...

GIT_ROOT=$(git rev-parse --show-toplevel)

for file in "$@"; do
	# continue if exist
	[ -e "$file" ] || continue

	# continue if not symlink
	[ ! -L "$file" ] || continue

	# continue if extension = svg
	[ "${file##*.}" == "svg" ] || continue

	echo "=> Workon '$file' ..." >&2

	# optimize
	svgo --config="$GIT_ROOT/tools/svgo.yml" -i "$file"

	# fix
	eval "$GIT_ROOT/tools/_fix_color_scheme.sh"	"$file"
done
