#!/usr/bin/env bash
#
# usage:
#  ./run_on_dirs.sh DIR...

SCRIPT_DIR=$(dirname "$0")

for dir in "$@"; do
	# continue if arg is directory
	[ -d "$dir" ] || continue

	echo "=> Directory '$dir'." >&2
	echo "   Press <CTRL-C> to abort (wait 5 seconds) ..." >&2

	sleep 5

	# get all svg files w/o symlinks
	FILES=$(find "$dir" -type f -name '*.svg' -print)

	for file in $FILES; do
		echo "=> Workon '$file' ..." >&2

		# optimize
		svgo --config="$SCRIPT_DIR/svgo.yml" -i "$file"

		# fix
		eval "$SCRIPT_DIR/_fix_color_scheme.sh"	"$file"
	done
done
