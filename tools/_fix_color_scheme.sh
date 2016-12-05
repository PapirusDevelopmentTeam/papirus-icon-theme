#!/bin/sh
#
# This script deletes a color property from style attribute
# if a class ColorScheme-* exist, and deletes the style
# attribute if is empty.
#
# limitations:
#  - works only with single-line elements
#
# usage:
#   _fix_color_scheme.sh FILE...

set -e

for file in "$@"; do
	[ -f "$file" ] || continue

	sed -r -i \
		-e '/class="ColorScheme-/ s/color:#([0-9a-zA-Z]{3}|[0-9a-zA-Z]{6});?//g' \
		-e 's/\s?style=""//g' "$file"
done
