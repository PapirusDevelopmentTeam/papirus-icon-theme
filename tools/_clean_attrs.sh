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
#  This script removes unused attributes and removes attributes with default
#  values from elements.
#  More details https://www.w3.org/TR/SVG/attindex.html
#
# Usage:
#  _clean_attrs.sh FILE...

set -e

# remove unused attributes
#  - properties in a style attribute has higher priority
sed -i --regexp-extended \
	-e 's/[ ]id="circle[0-9][^ ]*"//gI' \
	-e 's/[ ]id="defs[0-9][^ ]*"//gI' \
	-e 's/[ ]id="g[0-9][^ ]*"//gI' \
	-e 's/[ ]id="path[0-9][^ ]*"//gI' \
	-e 's/[ ]id="rect[0-9][^ ]*"//gI' \
	-e 's/[ ]id="svg[0-9][^ ]*"//gI' \
	-e '/style=/ {
		/fill:[^;"]/ s/[ ]fill="[^"]+"//gI
	}' \
	-e '/style=/ {
		/[^-]opacity:[^;"]/ s/[ ]opacity="[^"]+"//gI
	}' \
	"$@"


# remove attributes with default values
sed -i --regexp-extended \
	-e 's/[ ]alignment-baseline="auto"//gI' \
	-e 's/[ ]baseline-shift="baseline"//gI' \
	-e 's/[ ]clip-path="none"//gI' \
	-e 's/[ ]clip-rule="nonzero"//gI' \
	-e 's/[ ]clip="auto"//gI' \
	-e 's/[ ]color-interpolation-filters="linearRGB"//gI' \
	-e 's/[ ]color-interpolation="sRGB"//gI' \
	-e 's/[ ]color-profile="auto"//gI' \
	-e 's/[ ]color-rendering="auto"//gI' \
	-e 's/[ ]cursor="auto"//gI' \
	-e 's/[ ]direction="ltr"//gI' \
	-e 's/[ ]display="inline"//gI' \
	-e 's/[ ]dominant-baseline="auto"//gI' \
	-e 's/[ ]enable-background="accumulate"//gI' \
	-e 's/[ ]fill-opacity="[1-9][0-9.]*"//gI' \
	-e 's/[ ]fill-rule="nonzero"//gI' \
	-e 's/[ ]fill="(#000|#000000|black)"//gI' \
	-e 's/[ ]filter="none"//gI' \
	-e 's/[ ]flood-color="(#000|#000000|black)"//gI' \
	-e 's/[ ]flood-opacity="[1-9][0-9.]*"//gI' \
	-e 's/[ ]font-size-adjust="none"//gI' \
	-e 's/[ ]font-size="medium"//gI' \
	-e 's/[ ]font-stretch="normal"//gI' \
	-e 's/[ ]font-style="normal"//gI' \
	-e 's/[ ]font-variant="normal"//gI' \
	-e 's/[ ]font-weight="normal"//gI' \
	-e 's/[ ]glyph-orientation-horizontal="0deg"//gI' \
	-e 's/[ ]glyph-orientation-vertical="auto"//gI' \
	-e 's/[ ]image-rendering="auto"//gI' \
	-e 's/[ ]kerning="auto"//gI' \
	-e 's/[ ]letter-spacing="normal"//gI' \
	-e 's/[ ]marker-end="none"//gI' \
	-e 's/[ ]marker-mid="none"//gI' \
	-e 's/[ ]marker-start="none"//gI' \
	-e 's/[ ]mask="none"//gI' \
	-e 's/[ ]opacity="[1-9][0-9.]*"//gI' \
	-e 's/[ ]pointer-events="visiblePainted"//gI' \
	-e 's/[ ]shape-rendering="auto"//gI' \
	-e 's/[ ]stroke-dasharray="none"//gI' \
	-e 's/[ ]stroke-dashoffset="0"//gI' \
	-e 's/[ ]stroke-linecap="butt"//gI' \
	-e 's/[ ]stroke-linejoin="miter"//gI' \
	-e 's/[ ]stroke-miterlimit="4"//gI' \
	-e 's/[ ]stroke-opacity="[1-9][0-9.]*"//gI' \
	-e 's/[ ]stroke-width="1"//gI' \
	-e 's/[ ]stroke="none"//gI' \
	-e 's/[ ]text-anchor="start"//gI' \
	-e 's/[ ]text-decoration="none"//gI' \
	-e 's/[ ]text-rendering="auto"//gI' \
	-e 's/[ ]unicode-bidi="normal"//gI' \
	-e 's/[ ]visibility="visible"//gI' \
	-e 's/[ ]word-spacing="normal"//gI' \
	-e 's/[ ]writing-mode="lr-tb"//gI' \
	"$@"
