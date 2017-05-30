#!/bin/sed -rf
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
#  Details https://www.w3.org/TR/SVG/attindex.html
#
# Usage:
#  sed -r -i -f _clean_attrs.sed FILE...

# remove unused attributes
s/[ ]aria-label="[^"]*"//gI

# delete default ids
s/[ ]id="circle[0-9][^ ]*"//gI
s/[ ]id="defs[0-9][^ ]*"//gI
s/[ ]id="g[0-9][^ ]*"//gI
s/[ ]id="path[0-9][^ ]*"//gI
s/[ ]id="rect[0-9][^ ]*"//gI
s/[ ]id="svg[0-9][^ ]*"//gI

# properties in a style attribute has higher priority
/style=/ {
	/fill:[^;"]/ s/[ ]fill="[^"]+"//gI
	/[^-]opacity:[^;"]/ s/[ ]opacity="[^"]+"//gI
}

# remove attributes with default values
s/[ ]alignment-baseline="auto"//gI
s/[ ]baseline-shift="baseline"//gI
s/[ ]clip-path="none"//gI
s/[ ]clip-rule="nonzero"//gI
s/[ ]clip="auto"//gI
s/[ ]color-interpolation-filters="linearRGB"//gI
s/[ ]color-interpolation="sRGB"//gI
s/[ ]color-profile="auto"//gI
s/[ ]color-rendering="auto"//gI
s/[ ]cursor="auto"//gI
s/[ ]direction="ltr"//gI
s/[ ]display="inline"//gI
s/[ ]dominant-baseline="auto"//gI
s/[ ]enable-background="accumulate"//gI
s/[ ]fill-opacity="[1-9][0-9.]*"//gI
s/[ ]fill-rule="nonzero"//gI
s/[ ]fill="(#000|#000000|black)"//gI
s/[ ]filter="none"//gI
s/[ ]flood-color="(#000|#000000|black)"//gI
s/[ ]flood-opacity="[1-9][0-9.]*"//gI
s/[ ]font-size-adjust="none"//gI
s/[ ]font-size="medium"//gI
s/[ ]font-stretch="normal"//gI
s/[ ]font-style="normal"//gI
s/[ ]font-variant="normal"//gI
s/[ ]font-weight="normal"//gI
s/[ ]glyph-orientation-horizontal="0deg"//gI
s/[ ]glyph-orientation-vertical="auto"//gI
s/[ ]image-rendering="auto"//gI
s/[ ]kerning="auto"//gI
s/[ ]letter-spacing="normal"//gI
s/[ ]marker-end="none"//gI
s/[ ]marker-mid="none"//gI
s/[ ]marker-start="none"//gI
s/[ ]mask="none"//gI
s/[ ]opacity="[1-9][0-9.]*"//gI
s/[ ]pointer-events="visiblePainted"//gI
s/[ ]shape-rendering="auto"//gI
s/[ ]stroke-dasharray="none"//gI
s/[ ]stroke-dashoffset="0"//gI
s/[ ]stroke-linecap="butt"//gI
s/[ ]stroke-linejoin="miter"//gI
s/[ ]stroke-miterlimit="4"//gI
s/[ ]stroke-opacity="[1-9][0-9.]*"//gI
s/[ ]stroke-width="1"//gI
s/[ ]stroke="none"//gI
s/[ ]text-anchor="start"//gI
s/[ ]text-decoration="none"//gI
s/[ ]text-rendering="auto"//gI
s/[ ]unicode-bidi="normal"//gI
s/[ ]visibility="visible"//gI
s/[ ]word-spacing="normal"//gI
s/[ ]writing-mode="lr-tb"//gI
