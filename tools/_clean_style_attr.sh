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
#  This script removes unused properties and removes properties with default
#  values from style attributes.
#  More details https://www.w3.org/TR/SVG/styling.html
#
# Ignore property:
#  - fill
#  - fill-opacity
#  - opacity
#
# Usage:
#  _clean_style_attr.sh FILE...

set -e

# removes unused properties
# NOTE: delete a color property if currentColor not exists and fill have a value
sed -i \
	-e '/style=/ { /-inkscape-/ s/-inkscape-[^;"]\+;\?// }' \
	-e '/style=/ { /fill:none/ s/fill-rule:[^;"]\+;\?// }' \
	-e '/style=/ { /stroke:none/ s/stroke-width:[^;"]\+;\?// }' \
	-e '/style=/ { /stroke:none/ s/stroke-linecap:[^;"]\+;\?// }' \
	-e '/style=/ { /stroke:none/ s/stroke-linejoin:[^;"]\+;\?// }' \
	-e '/style=/ { /stroke:none/ s/stroke-miterlimit:[^;"]\+;\?// }' \
	-e '/style=/ { /stroke:none/ s/stroke-dasharray:[^;"]\+;\?// }' \
	-e '/style=/ { /stroke:none/ s/stroke-dashoffset:[^;"]\+;\?// }' \
	-e '/style=/ { /stroke:none/ s/stroke-opacity:[^;"]\+;\?// }' \
	-e '/style=/ {
		/currentColor/! {
			/fill[:=]"\?none/! {
				/fill[:=]"\?[^;"]/ s/\([^-]\)color:#[[:xdigit:]]\+;\?/\1/
			}
		}
	}' \
	"$@"

# removes properties with default values
sed -i \
	-e '/style=/ s/font-family:\(sans\|sans-serif\);\?//I' \
	-e '/style=/ s/font-style:normal;\?//I' \
	-e '/style=/ s/font-variant:normal;\?//I' \
	-e '/style=/ s/font-weight:normal;\?//I' \
	-e '/style=/ s/font-stretch:normal;\?//I' \
	-e '/style=/ s/font-size:medium;\?//I' \
	-e '/style=/ s/font-size-adjust:none;\?//I' \
	-e '/style=/ s/kerning:auto;\?//I' \
	-e '/style=/ s/line-height:normal;\?//I' \
	-e '/style=/ s/text-indent:0[^0-9."];\?//I' \
	-e '/style=/ s/text-align:start;\?//I' \
	-e '/style=/ s/text-decoration:none;\?//I' \
	-e '/style=/ s/text-decoration-line:none;\?//I' \
	-e '/style=/ s/text-decoration-style:solid;\?//I' \
	-e '/style=/ s/text-decoration-color:\(#000000\|black\|currentColor\);\?//I' \
	-e '/style=/ s/letter-spacing:normal;\?//I' \
	-e '/style=/ s/word-spacing:normal;\?//I' \
	-e '/style=/ s/text-transform:none;\?//I' \
	-e '/style=/ s/block-progression:tb;\?//I' \
	-e '/style=/ s/writing-mode:lr-tb;\?//I' \
	-e '/style=/ s/glyph-orientation-vertical:auto;\?//I' \
	-e '/style=/ s/glyph-orientation-horizontal:0deg;\?//I' \
	-e '/style=/ s/direction:ltr;\?//I' \
	-e '/style=/ s/unicode-bidi:normal;\?//I' \
	-e '/style=/ s/text-anchor:start;\?//I' \
	-e '/style=/ s/dominant-baseline:auto;\?//I' \
	-e '/style=/ s/alignment-baseline:auto;\?//I' \
	-e '/style=/ s/baseline-shift:baseline;\?//I' \
	-e '/style=/ s/white-space:normal;\?//I' \
	-e '/style=/ s/clip:auto;\?//I' \
	-e '/style=/ s/clip-path:none;\?//I' \
	-e '/style=/ s/clip-rule:nonzero;\?//I' \
	-e '/style=/ s/mask:none;\?//I' \
	-e '/style=/ s/display:inline;\?//I' \
	-e '/style=/ s/overflow:visible;\?//I' \
	-e '/style=/ s/visibility:visible;\?//I' \
	-e '/style=/ s/isolation:auto;\?//I' \
	-e '/style=/ s/mix-blend-mode:normal;\?//I' \
	-e '/style=/ s/color-interpolation:sRGB;\?//I' \
	-e '/style=/ s/color-interpolation-filters:linearRGB;\?//I' \
	-e '/style=/ s/solid-color:\(#000000\|black\);\?//I' \
	-e '/style=/ s/solid-opacity:1[^0-9."];\?//I' \
	-e '/style=/ s/fill-rule:nonzero;\?//I' \
	-e '/style=/ s/stroke:none;\?//I' \
	-e '/style=/ s/stroke-width:1[^0-9."];\?//I' \
	-e '/style=/ s/stroke-linecap:butt;\?//I' \
	-e '/style=/ s/stroke-linejoin:miter;\?//I' \
	-e '/style=/ s/stroke-miterlimit:4[^0-9."];\?//I' \
	-e '/style=/ s/stroke-dasharray:none;\?//I' \
	-e '/style=/ s/stroke-dashoffset:0[^0-9."];\?//I' \
	-e '/style=/ s/stroke-opacity:1[^0-9."];\?//I' \
	-e '/style=/ s/marker:none;\?//I' \
	-e '/style=/ s/marker-start:none;\?//I' \
	-e '/style=/ s/marker-mid:none;\?//I' \
	-e '/style=/ s/marker-end:none;\?//I' \
	-e '/style=/ s/paint-order:normal;\?//I' \
	-e '/style=/ s/color-rendering:auto;\?//I' \
	-e '/style=/ s/shape-rendering:auto;\?//I' \
	-e '/style=/ s/text-rendering:auto;\?//I' \
	-e '/style=/ s/image-rendering:auto;\?//I' \
	-e '/style=/ s/enable-background:accumulate;\?//I' \
	-e '/style=/ s/\s\?style=""//I' "$@"
