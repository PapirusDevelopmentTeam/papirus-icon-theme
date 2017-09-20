#!/usr/bin/env bash
#
# This script creates new SVG files from templates

set -eo pipefail

SCRIPT_DIR="$(dirname "$0")"
TARGET_DIR="$SCRIPT_DIR/Papirus"

if [ -n "$2" ]; then
	ICON_NAME=${2%*.svg}
fi

ICON_NAME=${ICON_NAME:=icon}

case "$1" in
	actions|ac*)
		for size in '16x16' '22x22' '24x24'; do
			cp -v "$TARGET_DIR/actions/_TEMPLATE@${size}.SVG" \
				"$TARGET_DIR/actions/${ICON_NAME}@${size}.svg"
		done
		;;
	apps|ap*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48' '64x64'; do
			cp -v "$TARGET_DIR/apps/_TEMPLATE@${size}.SVG" \
				"$TARGET_DIR/apps/${ICON_NAME}@${size}.svg"
		done
		;;
	devices|d*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48' '64x64'; do
			cp -v "$TARGET_DIR/devices/_TEMPLATE@${size}.SVG" \
				"$TARGET_DIR/devices/${ICON_NAME}@${size}.svg"
		done
		;;
	emblems|e*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48'; do
			cp -v "$TARGET_DIR/emblems/_TEMPLATE@${size}.SVG" \
				"$TARGET_DIR/emblems/${ICON_NAME}@${size}.svg"
		done
		;;
	mimetypes|m*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48' '64x64'; do
			cp -v "$TARGET_DIR/mimetypes/_TEMPLATE@${size}.SVG" \
				"$TARGET_DIR/mimetypes/${ICON_NAME}@${size}.svg"
		done
		;;
	panel|pa*)
		for size in '22x22' '24x24'; do
			cp -v "$TARGET_DIR/panel/_TEMPLATE@${size}.SVG" \
				"$TARGET_DIR/panel/${ICON_NAME}@${size}.svg"
		done
		;;
	places|pl*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48' '64x64'; do
			cp -v "$TARGET_DIR/places/_TEMPLATE@${size}.SVG" \
				"$TARGET_DIR/places/${ICON_NAME}@${size}.svg"
		done
		;;
	status|s*)
		for size in '22x22' '24x24' '32x32' '48x48'; do
			cp -v "$TARGET_DIR/status/_TEMPLATE@${size}.SVG" \
				"$TARGET_DIR/status/${ICON_NAME}@${size}.svg"
		done
		;;
	*)
		cat <<-EOF
		This script creates new SVG files from templates.

		Usage:
		  $0 context [icon name]

		  available contexts:
		    [ac]tions
		    [ap]ps
		    [d]evices
		    [e]mblems
		    [m]imetypes
		    [pa]nel
		    [pl]aces
		    [s]tatus

		Examples:
		  $0 apps clementine.svg
		  $0 panel mumble-indicator.svg
		  $0 mime text-x-ruby.svg
		EOF

		exit 2
		;;
esac
