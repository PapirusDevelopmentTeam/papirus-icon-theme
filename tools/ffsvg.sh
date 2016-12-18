#!/bin/sh
#
# Written in 2016 by Sergei Eremenko <https://github.com/SmartFinn>
#
# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software. If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.
#
# Description:
#  This script finds, fixes and cleans SVG files.
#
# Usage:
#  ffsvg.sh PATH...

set -e

SCRIPT_DIR=$(dirname "$0")

_run_helpers() {
	echo "=> Working on '$1' ..." >&2

	# optimize a SVG
	svgo --config="$SCRIPT_DIR/_svgo.yml" -i "$1"

	# fix a color scheme
	eval "$SCRIPT_DIR/_fix_color_scheme.sh"	"$1"

	# clear a style attribute
	eval "$SCRIPT_DIR/_clean_style_attr.sh"	"$1"
}

for i in "$@"; do
	if [ -d "$i" ]; then
		# is a directory

		echo "=> Directory '$i' will be processed." >&2
		echo "   Press <CTRL-C> to abort (wait 3 seconds) ..." >&2

		sleep 3

		# process all SVG files w/o symlinks
		find "$i" -type f -name '*.svg' | while read file; do
			_run_helpers "$file"
		done
	elif [ -f "$i" ] && [ ! -L "$i" ]; then
		# is a file and is not a symlink

		# continue if an extension is svg
		[ "${i##*.}" = "svg" ] || continue

		_run_helpers "$i"
	else
		continue
	fi
done
