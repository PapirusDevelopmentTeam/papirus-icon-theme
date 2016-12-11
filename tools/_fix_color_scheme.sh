#!/bin/sh
#
# This script looks in the SVG files for certain colors and replaces
# them with the corresponding stylesheet class. And fixes the color
# scheme after Inkscape.
#
# limitations:
#  - works only with one element per line
#
# usage:
#   _fix_color_scheme.sh FILE...

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
	[ -f "$file" ] || continue

	# skip if a file not have color scheme
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
