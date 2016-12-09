#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
_PAPIRUS_DIR="$SCRIPT_DIR/Papirus"

case "$1" in
	actions|ac*)
		for size in '16x16' '22x22' '24x24'; do
			cp -v "$_PAPIRUS_DIR/actions/_TEMPLATE@${size}.SVG" \
				"$_PAPIRUS_DIR/actions/${2:-newicon}@${size}.svg"
		done
		;;
	apps|ap*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48'; do
			cp -v "$_PAPIRUS_DIR/apps/_TEMPLATE@${size}.SVG" \
				"$_PAPIRUS_DIR/apps/${2:-newicon}@${size}.svg"
		done
		;;
	devices|d*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48'; do
			cp -v "$_PAPIRUS_DIR/devices/_TEMPLATE@${size}.SVG" \
				"$_PAPIRUS_DIR/devices/${2:-newicon}@${size}.svg"
		done
		;;
	emblems|e*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48'; do
			cp -v "$_PAPIRUS_DIR/emblems/_TEMPLATE@${size}.SVG" \
				"$_PAPIRUS_DIR/emblems/${2:-newicon}@${size}.svg"
		done
		;;
	mimetypes|m*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48' '64x64'; do
			cp -v "$_PAPIRUS_DIR/mimetypes/_TEMPLATE@${size}.SVG" \
				"$_PAPIRUS_DIR/mimetypes/${2:-newicon}@${size}.svg"
		done
		;;
	panel|pa*)
		for size in '22x22' '24x24'; do
			cp -v "$_PAPIRUS_DIR/panel/_TEMPLATE@${size}.SVG" \
				"$_PAPIRUS_DIR/panel/${2:-newicon}@${size}.svg"
		done
		;;
	places|pl*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48' '64x64'; do
			cp -v "$_PAPIRUS_DIR/places/_TEMPLATE@${size}.SVG" \
				"$_PAPIRUS_DIR/places/${2:-newicon}@${size}.svg"
		done
		;;
	status|s*)
		for size in '22x22' '24x24' '32x32' '48x48'; do
			cp -v "$_PAPIRUS_DIR/status/_TEMPLATE@${size}.SVG" \
				"$_PAPIRUS_DIR/status/${2:-newicon}@${size}.svg"
		done
		;;
	*)
		cat <<-EOF
		  Usage:
		    $0 context [icon name]

		    context available:
		      [ac]tions
		      [ap]ps
		      [d]evices
		      [e]mblems
		      [m]imetypes
		      [pa]nel
		      [pl]aces
		      [s]tatus
		EOF
		;;
esac
