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
#  This script removes unused properties and removes properties with default
#  values from style attributes.
#  Details https://www.w3.org/TR/SVG/styling.html
#
# Get CSS defaults from Inkscape:
#	sed -e '/^$/d' -e '/NO.DEFAULT/d' -e 's/"//g' \
#		/usr/share/inkscape/attributes/css_defaults \
#		| awk -F" - " '{printf "s/%s:%s;//gI\n", $1,$2}'
#
# Usage:
#  sed -r -i -f _clean_style_attr.sed FILE...

/style=/ {

	# add a trailing semicolon for secure matching
	s/style="([^"]+[^;])"/style="\1;"/gI

	# delete properties with default values
	s/alignment-baseline:auto;//gI
	s/backface-visibility:visible;//gI
	s/baseline-shift:baseline;//gI
	s/block-progression:tb;//gI
	s/clip:auto;//gI
	s/clip-path:none;//gI
	s/clip-rule:nonzero;//gI
	s/color-interpolation:sRGB;//gI
	s/color-interpolation-filters:linearRGB;//gI
	s/color-profile:auto;//gI
	s/color-rendering:auto;//gI
	s/cursor:auto;//gI
	s/direction:ltr;//gI
	s/display:inline;//gI
	s/dominant-baseline:auto;//gI
	s/enable-background:accumulate;//gI
	s/fill:black;//gI
	s/fill-opacity:1;//gI
	s/fill-rule:nonzero;//gI
	s/filter:none;//gI
	s/flood-color:black;//gI
	s/flood-opacity:1;//gI
	s/font-feature-settings:normal;//gI
	s/font-size:medium;//gI
	s/font-size-adjust:none;//gI
	s/font-stretch:normal;//gI
	s/font-style:normal;//gI
	s/font-variant:normal;//gI
	s/font-variant-alternates:normal;//gI
	s/font-variant-caps:normal;//gI
	s/font-variant-east-asian:normal;//gI
	s/font-variant-ligatures:normal;//gI
	s/font-variant-numeric:normal;//gI
	s/font-variant-position:normal;//gI
	s/font-weight:normal;//gI
	s/glyph-orientation-horizontal:0deg;//gI
	s/glyph-orientation-vertical:auto;//gI
	s/image-rendering:auto;//gI
	s/isolation:auto;//gI
	s/kerning:auto;//gI
	s/letter-spacing:normal;//gI
	s/lighting-color:white;//gI
	s/marker:none;//gI
	s/marker-end:none;//gI
	s/marker-mid:none;//gI
	s/marker-start:none;//gI
	s/mask:none;//gI
	s/mix-blend-mode:normal;//gI
	s/([^-])opacity:1;/\1/gI
	s/overflow:hidden;//gI
	s/paint-order:normal;//gI
	s/perspective:none;//gI
	s/pointer-events:visiblePainted;//gI
	s/shape-inside:auto;//gI
	s/shape-margin:0;//gI
	s/shape-outside:auto;//gI
	s/shape-padding:none;//gI
	s/shape-rendering:auto;//gI
	s/solid-color:#000000;//gI
	s/solid-opacity:1;//gI
	s/stop-color:black;//gI
	s/stop-opacity:1;//gI
	s/stroke:none;//gI
	s/stroke-dasharray:none;//gI
	s/stroke-dashoffset:0;//gI
	s/stroke-linecap:butt;//gI
	s/stroke-linejoin:miter;//gI
	s/stroke-miterlimit:4;//gI
	s/stroke-opacity:1;//gI
	s/stroke-width:1;//gI
	s/text-align:start;//gI
	s/text-anchor:start;//gI
	s/text-decoration-line:none;//gI
	s/text-decoration-style:solid;//gI
	s/text-decoration:none;//gI
	s/text-indent:0;//gI
	s/text-orientation:mixed;//gI
	s/text-rendering:auto;//gI
	s/text-transform:none;//gI
	s/transform:none;//gI
	s/transform-style:flat;//gI
	s/unicode-bidi:normal;//gI
	s/vector-effect:none;//gI
	s/visibility:visible;//gI
	s/white-space:normal;//gI
	s/word-spacing:normal;//gI
	s/writing-mode:lr-tb;//gI

	# delete properties with nonsense values
	s/fill-opacity:[1-9][0-9.]*;//gI
	s/font-family:(sans|sans-serif);//gI
	s/line-height:normal;//gI
	s/([^-])opacity:[1-9][0-9.]*;/\1/gI
	s/overflow:visible;//gI
	s/shape-padding:0;//gI
	s/solid-color:(#000|#000000|black);//gI
	s/solid-opacity:[1-9][0-9.]*;//gI
	s/stroke-opacity:[1-9][0-9.]*;//gI
	s/text-decoration-color:(#000|#000000|black|currentColor);//gI

	# delete unsupported properties
	s/paint-order:fill stroke markers;//gI
	s/paint-order:stroke fill markers;//gI
	s/paint-order:fill markers stroke;//gI
	s/paint-order:markers fill stroke;//gI
	s/paint-order:stroke markers fill;//gI
	s/paint-order:markers stroke fill;//gI

	# delete Inkscape properties
	/-inkscape-/ {
		s/-inkscape-[^;"]+;//gI
	}

	# delete 'fill- *' properties if fill equal none
	/fill[:=]"?none/ {
		s/fill-rule:[^;"]+;//gI
		s/fill-opacity:[^;"]+;//gI
	}

	# delete a fill property if it has the default value and fill attribute not exist
	/fill="[^"]/! {
		s/fill:(#000|#000000|black);//gI
	}

	# delete a color property if currentColor not exists and fill has a value
	/currentColor/! {
		s/([^-])color:[^;"]+;/\1/gI
	}

	# delete 'stroke- *' properties if an object doesn't have a stroke
	/stroke[:=]/! {
		s/stroke-width:[^;"]+;//gI
		s/stroke-linecap:[^;"]+;//gI
		s/stroke-linejoin:[^;"]+;//gI
		s/stroke-miterlimit:[^;"]+;//gI
		s/stroke-dasharray:[^;"]+;//gI
		s/stroke-dashoffset:[^;"]+;//gI
		s/stroke-opacity:[^;"]+;//gI
	}

	# delete 'clip-rule' properties if an object doesn't have a clip-path
	/clip-path[:=]/! {
		s/clip-rule:[^;"]+;//gI
	}

	# delete unused properties from non-container elements
	/<(a|defs|glyph|g|marker|mask|missing-glyph|pattern|svg|switch|symbol|use)/! {
		s/enable-background:[^;"]+;//gI
	}

	# delete useless properties from elements
	# https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/fill-rule
	/<(altGlyph|path|polygon|polyline|text|textPath|tref|tspan)/! {
		s/fill-rule:[^;"]+;//gI
	}

	# delete unused properties from non-text content elements
	/<(altGlyph|textPath|text|tref|tspan|flowRoot|flowPara|flowSpan|a|defs|glyph|g|marker|mask|missing-glyph|pattern|svg|switch|symbol|use)/! {
		s/alignment-baseline:[^;"]+;//gI
		s/baseline-shift:[^;"]+;//gI
		s/block-progression:[^;"]+;//gI
		s/direction:[^;"]+;//gI
		s/dominant-baseline:[^;"]+;//gI
		s/font:[^;"]+;//gI
		s/font-family:[^;"]+;//gI
		s/font-feature-settings:[^;"]+;//gI
		s/font-size-adjust:[^;"]+;//gI
		s/font-size:[^;"]+;//gI
		s/font-stretch:[^;"]+;//gI
		s/font-style:[^;"]+;//gI
		s/font-variant-alternates:[^;"]+;//gI
		s/font-variant-caps:[^;"]+;//gI
		s/font-variant-ligatures:[^;"]+;//gI
		s/font-variant-numeric:[^;"]+;//gI
		s/font-variant-position:[^;"]+;//gI
		s/font-variant:[^;"]+;//gI
		s/font-weight:[^;"]+;//gI
		s/glyph-orientation-horizontal:[^;"]+;//gI
		s/glyph-orientation-vertical:[^;"]+;//gI
		s/kerning:[^;"]+;//gI
		s/letter-spacing:[^;"]+;//gI
		s/line-height:[^;"]+;//gI
		s/text-align:[^;"]+;//gI
		s/text-anchor:[^;"]+;//gI
		s/text-decoration-color:[^;"]+;//gI
		s/text-decoration-line:[^;"]+;//gI
		s/text-decoration-style:[^;"]+;//gI
		s/text-decoration:[^;"]+;//gI
		s/text-indent:[^;"]+;//gI
		s/text-orientation:[^;"]+;//gI
		s/text-transform:[^;"]+;//gI
		s/unicode-bidi:[^;"]+;//gI
		s/word-spacing:[^;"]+;//gI
		s/writing-mode:[^;"]+;//gI
	}

	# replace 2 and more semicolons by one
	s/;{2,}/;/g

	# delete trailing semicolon
	s/;+"/"/g

	# delete style attribute if it's empty
	s/[[:space:]]?style=""//g
}
