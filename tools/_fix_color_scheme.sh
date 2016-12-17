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
#  This script looks in the SVG files for certain colors and replaces
#  them with the corresponding stylesheet class. Fixes a color scheme
#  after Inkscape.
#
# Limitations:
#  - works only with one element per line
#
# Usage:
#  _fix_color_scheme.sh FILE...

set -e

add_class() {
	# add the class if a value matches:
	sed -i -r \
		-e '/([^-]color|fill|stop-color):#5c616c/I s/(style="\S+")/\1 class="ColorScheme-Text"/' \
		-e '/([^-]color|fill|stop-color):#5294e2/I s/(style="\S+")/\1 class="ColorScheme-Highlight"/' \
		-e '/([^-]color|fill|stop-color):#d3dae3/I s/(style="\S+")/\1 class="ColorScheme-ButtonBackground"/' \
		"$@"
}

add_class_dark() {
	# add the class if a value matches:
	sed -i -r \
		-e '/([^-]color|fill|stop-color):#d3dae3/I s/(style="\S+")/\1 class="ColorScheme-Text"/' \
		-e '/([^-]color|fill|stop-color):#5294e2/I s/(style="\S+")/\1 class="ColorScheme-Highlight"/' \
		"$@"
}

fix_color_and_fill() {
	# if class exist:
	#   - remove color
	#   - replace fill=#HEXHEX to fill=currentColor
	sed -i -r \
		-e '/class="ColorScheme-/ s/([^-])color:#([[:xdigit:]]{3}|[[:xdigit:]]{6});?/\1/' \
		-e '/class="ColorScheme-/ s/fill:#([[:xdigit:]]{3}|[[:xdigit:]]{6});?/fill:currentColor;/' \
		-e '/class="ColorScheme-/ s/stop-color:#([[:xdigit:]]{3}|[[:xdigit:]]{6});?/stop-color:currentColor;/' \
		"$@"
}

for file in "$@"; do
	# continue if it is a file
	[ -f "$file" ] || continue

	# continue if the file has a color scheme
	grep -q -i '\.ColorScheme-Text' "$file" || continue

	fix_color_and_fill "$file"

	if grep -q -i '#5c616c' "$file"; then
		# is Papirus
		add_class "$file"
		fix_color_and_fill "$file"
	else
		# is Papirus-Dark
		add_class_dark "$file"
		fix_color_and_fill "$file"
	fi
done
