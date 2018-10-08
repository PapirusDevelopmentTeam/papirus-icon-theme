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

# Papirus, Papirus-Dark and Papirus-Light
add_class() {
	# add the class if a value matches:
	sed -i -r \
		-e '/([^-]color|fill|stop-color|stroke):(#5c616c|#d3dae3)/I s/(style="[^"]+")/\1 class="ColorScheme-Text"/' \
		-e '/([^-]color|fill|stop-color|stroke):#5294e2/I s/(style="[^"]+")/\1 class="ColorScheme-Highlight"/' \
		"$@"
}

# Papirus-Light
add_class_light() {
	# add the class if a value matches:
	sed -i -r \
		-e '/([^-]color|fill|stop-color|stroke):#31363b/I s/(style="[^"]+")/\1 class="ColorScheme-Text"/' \
		-e '/([^-]color|fill|stop-color|stroke):#3daee9/I s/(style="[^"]+")/\1 class="ColorScheme-Highlight"/' \
		"$@"
}

# ePapirus
add_class_e() {
	# add the class if a value matches:
	sed -i -r \
		-e '/([^-]color|fill|stop-color|stroke):(#6e6e6e|#ffffff)/I s/(style="[^"]+")/\1 class="ColorScheme-Text"/' \
		-e '/([^-]color|fill|stop-color|stroke):#5294e2/I s/(style="[^"]+")/\1 class="ColorScheme-Highlight"/' \
		"$@"
}

# Symbolic
add_class_symbolic() {
	# add the class if a value matches and class="warning" not exists:
	sed -i -r \
		-e '/class="warning"/! { /([^-]color|fill|stop-color|stroke):#5294e2/I s/(style="[^"]+")/\1 class="warning"/ }' \
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

		replace_hex_to_current_color "$file"

		if grep -q -i 'color:\(#6e6e6e\|#ffffff\)' "$file"; then
			# it's ePapirus
			add_class_e "$file"
		elif  grep -q -i 'color:\(#31363b\|#3daee9\)' "$file"; then
			# it's Papirus-Light
			add_class_light "$file"
		elif  grep -q -i 'color:\(#5c616c\|#d3dae3\)' "$file"; then
			# it's Papirus or Papirus-Dark
			add_class "$file"
		else
			echo "'$file' has an unknown CSS stylesheet!" >&2
		fi

		replace_hex_to_current_color "$file"
	else
		case "$file" in
			*-symbolic.svg|*-symbolic-rtl.svg|*-symbolic@symbolic.svg)
				# it's symbolic icon
				add_class_symbolic "$file"
				;;
			*)
				continue
				;;
		esac
	fi
done
