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

SCRIPT_DIR="$(dirname "$0")"

_run_helpers() {
	echo "=> Working on '$1' ..."

	# optimize a SVG
	if command -v svgo > /dev/null 2>&1; then
		# use SVGO
		svgo --config="$SCRIPT_DIR/_svgo.yml" -i "$1"
	elif command -v scour > /dev/null 2>&1; then
		# use scour
		"$SCRIPT_DIR/_scour.sh" "$1"
	else
		cat >&2 <<-'EOF'

		You have to install svgo or scour to use this script:

		sudo npm install -g svgo
		sudo apt-get install python-scour

		EOF

		exit 1
	fi

	# fix a color scheme
	"$SCRIPT_DIR/_fix_color_scheme.sh" "$1"

	# clear attributes
	sed -r -i -f "$SCRIPT_DIR/_clean_attrs.sed" "$1"

	# clear a style attribute
	sed -r -i -f "$SCRIPT_DIR/_clean_style_attr.sed" "$1"
}

for i in "$@"; do
	if [ -d "$i" ]; then
		# it's a directory

		echo "=> Directory '$i' will be processed."
		echo "   Press <CTRL-C> to abort (wait 1 seconds) ..."

		sleep 1

		# process all SVG files w/o symlinks
		find "$i" -type f -name '*.svg' | while read -r file; do
			_run_helpers "$file"
		done
	elif [ -f "$i" ] && [ ! -L "$i" ]; then
		# it's a file and not a symlink

		# continue if an extension is svg
		[ "${i##*.}" = "svg" ] || continue

		_run_helpers "$i"
	else
		continue
	fi
done
