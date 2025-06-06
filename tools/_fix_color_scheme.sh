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

# Papirus, Papirus-Dark, and Papirus-Light
add_css_classes() {
	# 1. remove class="ColorScheme-*" if currentColor is missing
	# 2. remove class="ColorScheme-*" if color property is set
	# 3-7. add KDE ColorScheme-* and GNOME symbolic classes if color value matches
	sed -i -r \
		-e '/:currentColor/! s/[ ]class="ColorScheme-[^"]+"//g' \
		-e '/[^-]color:[^;"]/ s/[ ]class="ColorScheme-[^"]+"//g' \
		-e '/([^-]color|fill|stop-color|stroke):(#444444|#dfdfdf)/I s/(style="[^"]+")/\1 class="ColorScheme-Text"/' \
		-e '/([^-]color|fill|stop-color|stroke):#4285f4/I s/(style="[^"]+")/\1 class="ColorScheme-Highlight"/' \
		-e '/([^-]color|fill|stop-color|stroke):#4caf50/I s/(style="[^"]+")/\1 class="ColorScheme-PositiveText success"/' \
		-e '/([^-]color|fill|stop-color|stroke):#ff9800/I s/(style="[^"]+")/\1 class="ColorScheme-NeutralText warning"/' \
		-e '/([^-]color|fill|stop-color|stroke):#f44336/I s/(style="[^"]+")/\1 class="ColorScheme-NegativeText error"/' \
		"$@"
}

replace_hex_to_current_color() {
	# if class exist:
	#   - remove color
	#   - replace fill=#HEXHEX to fill=currentColor
	sed -i -r \
		-e '/class="ColorScheme-/ s/([^-])color:#([[:xdigit:]]{3}|[[:xdigit:]]{6});?/\1/' \
		-e '/class="ColorScheme-/ s/fill:#([[:xdigit:]]{3}|[[:xdigit:]]{6});?/fill:currentColor;/' \
		-e '/class="ColorScheme-/ s/stroke:#([[:xdigit:]]{3}|[[:xdigit:]]{6});?/stroke:currentColor;/' \
		-e '/class="ColorScheme-/ s/stop-color:#([[:xdigit:]]{3}|[[:xdigit:]]{6});?/stop-color:currentColor;/' \
		"$@"
}

for file in "$@"; do
	# continue if it's a file
	[ -f "$file" ] || continue

	if grep -q -i '\.ColorScheme-Text' "$file"; then
		# the file has a color scheme

		if grep -q -i 'color:\(#444444\|#dfdfdf\)' "$file"; then
			# it's Papirus, Papirus-Dark, or Papirus-Light
			add_css_classes "$file"
		else
			echo "'$file' has unknown colors!" >&2
		fi

		replace_hex_to_current_color "$file"
	fi
done
