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
# Usage:
#  _clean_style_attr.sh FILE...

set -e

# remove unused properties
#  - delete fill property if it have default value and fill attribute not exist
#  - delete a color property if currentColor not exists and fill have a value
#  - delete unused property from non-container elements
sed -i --regexp-extended \
	-e '/style=/ { /-inkscape-/ s/-inkscape-[^;"]+;?//gI }' \
	-e '/style=/ { /fill[:=]"?none/ s/fill-rule:[^;"]+;?//gI }' \
	-e '/style=/ { /fill[:=]"?none/ s/fill-opacity:[^;"]+;?//gI }' \
	-e '/style=/ { /stroke[:=]"?(|none)/! s/stroke-width:[^;"]+;?//gI }' \
	-e '/style=/ { /stroke[:=]"?(|none)/! s/stroke-linecap:[^;"]+;?//gI }' \
	-e '/style=/ { /stroke[:=]"?(|none)/! s/stroke-linejoin:[^;"]+;?//gI }' \
	-e '/style=/ { /stroke[:=]"?(|none)/! s/stroke-miterlimit:[^;"]+;?//gI }' \
	-e '/style=/ { /stroke[:=]"?(|none)/! s/stroke-dasharray:[^;"]+;?//gI }' \
	-e '/style=/ { /stroke[:=]"?(|none)/! s/stroke-dashoffset:[^;"]+;?//gI }' \
	-e '/style=/ { /stroke[:=]"?(|none)/! s/stroke-opacity:[^;"]+;?//gI }' \
	-e '/style=/ { /fill="[^"]/! s/fill:(#000|#000000|black);?//gI }' \
	-e '/style=/ {
		/currentColor/! {
			/fill[:=]"?[^;"]/ s/([^-])color:[^;"]+;?/\1/gI
		}
	}' \
	-e '/style=/ {
		/<(defs|g|marker|mask|svg|symbol)/! s/enable-background:[^;"]+;?//gI
	}' \
	"$@"


# remove properties with default values
#  - delete style attribute if it's empty
sed -i --regexp-extended \
	-e '/style=/ s/font-family:(sans|sans-serif);?//gI' \
	-e '/style=/ s/font-style:normal;?//gI' \
	-e '/style=/ s/font-variant:normal;?//gI' \
	-e '/style=/ s/font-weight:normal;?//gI' \
	-e '/style=/ s/font-stretch:normal;?//gI' \
	-e '/style=/ s/font-size:medium;?//gI' \
	-e '/style=/ s/font-size-adjust:none;?//gI' \
	-e '/style=/ s/kerning:auto;?//gI' \
	-e '/style=/ s/line-height:normal;?//gI' \
	-e '/style=/ s/text-indent:0([;"]){1,}/\1/gI' \
	-e '/style=/ s/text-align:start;?//gI' \
	-e '/style=/ s/text-decoration:none;?//gI' \
	-e '/style=/ s/text-decoration-line:none;?//gI' \
	-e '/style=/ s/text-decoration-style:solid;?//gI' \
	-e '/style=/ s/text-decoration-color:(#000|#000000|black|currentColor);?//gI' \
	-e '/style=/ s/letter-spacing:normal;?//gI' \
	-e '/style=/ s/word-spacing:normal;?//gI' \
	-e '/style=/ s/text-transform:none;?//gI' \
	-e '/style=/ s/block-progression:tb;?//gI' \
	-e '/style=/ s/writing-mode:lr-tb;?//gI' \
	-e '/style=/ s/glyph-orientation-vertical:auto;?//gI' \
	-e '/style=/ s/glyph-orientation-horizontal:0deg;?//gI' \
	-e '/style=/ s/direction:ltr;?//gI' \
	-e '/style=/ s/unicode-bidi:normal;?//gI' \
	-e '/style=/ s/text-anchor:start;?//gI' \
	-e '/style=/ s/dominant-baseline:auto;?//gI' \
	-e '/style=/ s/alignment-baseline:auto;?//gI' \
	-e '/style=/ s/baseline-shift:baseline;?//gI' \
	-e '/style=/ s/white-space:normal;?//gI' \
	-e '/style=/ s/clip:auto;?//gI' \
	-e '/style=/ s/clip-path:none;?//gI' \
	-e '/style=/ s/clip-rule:nonzero;?//gI' \
	-e '/style=/ s/mask:none;?//gI' \
	-e '/style=/ s/display:inline;?//gI' \
	-e '/style=/ s/overflow:visible;?//gI' \
	-e '/style=/ s/visibility:visible;?//gI' \
	-e '/style=/ s/isolation:auto;?//gI' \
	-e '/style=/ s/mix-blend-mode:normal;?//gI' \
	-e '/style=/ s/color-interpolation:sRGB;?//gI' \
	-e '/style=/ s/color-interpolation-filters:linearRGB;?//gI' \
	-e '/style=/ s/solid-color:(#000|#000000|black);?//gI' \
	-e '/style=/ s/solid-opacity:[1-9][0-9.]*;?//gI' \
	-e '/style=/ s/fill-rule:nonzero;?//gI' \
	-e '/style=/ s/fill-opacity:[1-9][0-9.]*;?//gI' \
	-e '/style=/ s/([^-])opacity:[1-9][0-9.]*;?/\1/gI' \
	-e '/style=/ s/stroke:none;?//gI' \
	-e '/style=/ s/stroke-width:1([;"]){1,}/\1/gI' \
	-e '/style=/ s/stroke-linecap:butt;?//gI' \
	-e '/style=/ s/stroke-linejoin:miter;?//gI' \
	-e '/style=/ s/stroke-miterlimit:4([;"]){1,}/\1/gI' \
	-e '/style=/ s/stroke-dasharray:none;?//gI' \
	-e '/style=/ s/stroke-dashoffset:0([;"]){1,}/\1/gI' \
	-e '/style=/ s/stroke-opacity:[1-9][0-9.]*;?//gI' \
	-e '/style=/ s/marker:none;?//gI' \
	-e '/style=/ s/marker-start:none;?//gI' \
	-e '/style=/ s/marker-mid:none;?//gI' \
	-e '/style=/ s/marker-end:none;?//gI' \
	-e '/style=/ s/paint-order:normal;?//gI' \
	-e '/style=/ s/color-rendering:auto;?//gI' \
	-e '/style=/ s/shape-rendering:auto;?//gI' \
	-e '/style=/ s/text-rendering:auto;?//gI' \
	-e '/style=/ s/image-rendering:auto;?//gI' \
	-e '/style=/ s/enable-background:accumulate;?//gI' \
	-e '/style=/ s/[[:space:]]?style="[;]*"//gI' "$@"
