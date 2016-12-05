#!/usr/bin/env bash
#
# usage:
#  ./run_on_dirs.sh DIR...

GIT_ROOT=$(git rev-parse --show-toplevel)

for dir in "$@"; do
	# continue if arg is directory
	[ -d "$dir" ] || continue

	echo "=> Directory '$dir'." >&2
	echo "   Press <CTRL-C> to abort (wait 5 seconds) ..." >&2

	sleep 5

	# get all svg files w/o symlinks
	FILES=$(find "$dir" -type f -iname '*.svg' -print)

	for file in $FILES; do
		echo "=> Workon '$file' ..." >&2

		# optimize
		svgo --config="$GIT_ROOT/tools/svgo.yml" -i "$file"

		# fix
		eval "$GIT_ROOT/tools/_fix_color_scheme.sh"	"$file"
	done
done
