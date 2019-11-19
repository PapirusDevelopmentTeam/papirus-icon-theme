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

for i in "$@"; do
	if [ -f "$i" ] && [ ! -L "$i" ]; then
		# it's a file and not a symlink

		# continue if an extension is svg
		[ "${i##*.}" = "svg" ] || continue

		scour \
			--quiet \
			--disable-simplify-colors \
			--disable-style-to-xml \
			--remove-metadata \
			--renderer-workaround \
			--strip-xml-prolog \
			--set-precision=8 \
			--strip-xml-space \
			-i "$i" -o "$i".tmp

		# rename
		mv -f "$i".tmp "$i"
	else
		continue
	fi
done
