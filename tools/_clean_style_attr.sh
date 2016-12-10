#!/bin/sh
#
# removes unused properties and removes properties with default
# values from  style attributes
#
# https://www.w3.org/TR/SVG/styling.html
#
# ignore property:
#   - fill
#   - fill-opacity
#   - opacity
#
# usage:
#   _clean_style_attr.sh FILE...

set -e

# removes unused properties
# NOTE: delete a color property if currentColor not exists and fill have a value
sed -i \
	-e '/style=/ { /-inkscape-/ s/-inkscape-[0-9a-zA-Z:-]\+;\?//I }' \
	-e '/style=/ { /fill:none/ s/fill-rule:\(nonzero\|evenodd\|inherit\);\?//I }' \
	-e '/style=/ { /stroke:none/ s/stroke-width:[0-9a-zA-Z.%]\+;\?//I }' \
	-e '/style=/ { /stroke:none/ s/stroke-linecap:\(butt\|round\|square\|inherit\);\?//I }' \
	-e '/style=/ { /stroke:none/ s/stroke-linejoin:\(miter\|round\|bevel\|inherit\);\?//I }' \
	-e '/style=/ { /stroke:none/ s/stroke-miterlimit:[0-9]\+;\?//I }' \
	-e '/style=/ { /stroke:none/ s/stroke-dasharray:\(none\|[0-9,]\+\);\?//I }' \
	-e '/style=/ { /stroke:none/ s/stroke-dashoffset:[0-9a-zA-Z.%]\+;\?//I }' \
	-e '/style=/ { /stroke:none/ s/stroke-opacity:[0-9.]\+;\?//I }' \
	-e '/currentColor/! {
		/fill[:=]"\?none/! {
			/fill[:=]"\?[^;"]/ s/\([^-]\)color:#[0-9a-zA-Z]\+;\?/\1/I
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
	-e '/style=/ s/text-indent:0;\?//I' \
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
	-e '/style=/ s/solid-opacity:1;\?//I' \
	-e '/style=/ s/fill-rule:nonzero;\?//I' \
	-e '/style=/ s/stroke:none;\?//I' \
	-e '/style=/ s/stroke-width:1;\?//I' \
	-e '/style=/ s/stroke-linecap:butt;\?//I' \
	-e '/style=/ s/stroke-linejoin:miter;\?//I' \
	-e '/style=/ s/stroke-miterlimit:4;\?//I' \
	-e '/style=/ s/stroke-dasharray:none;\?//I' \
	-e '/style=/ s/stroke-dashoffset:0;\?//I' \
	-e '/style=/ s/stroke-opacity:1;\?//I' \
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
