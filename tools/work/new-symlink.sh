#!/usr/bin/env bash

set -eo pipefail

SCRIPT_DIR=$(dirname "$0")
_PAPIRUS_DIR="$SCRIPT_DIR/Papirus"

usage() {
	cat <<-EOF
	This script creates new symlinks to existing icons.

	Usage:
	  $0 context <symlink name> <icon name>

	  context available:
	    [ac]tions
	    [ap]ps
	    [d]evices
	    [e]mblems
	    [m]imetypes
	    [pa]nel
	    [pl]aces
	    [s]tatus

	Examples:

	  ./new-symlink.sh apps radiotray-ng-on.svg radiotray.svg
	  ./new-symlink.sh panel radiotray-ng-off-panel.svg radiotray_off.svg
	  ./new-symlink.sh panel radiotray-ng-on-panel.svg radiotray_on.svg
	  ./convert-to-e.sh
	  ./convert-to-dark.sh
	  ./convert-to-light.sh
	  ./copy-to-theme.sh
	  ./clean.sh
	EOF

	exit 2
}

[ -n "$3" ] || usage

CONTEXT="$1"
SYMLINK_NAME="${2%*.svg}"
TARGET_ICON="$3"

case "$CONTEXT" in
	actions|ac*)
		for size in '16x16' '22x22' '24x24'; do
			ln -sfv "$TARGET_ICON" \
				"$_PAPIRUS_DIR/actions/${SYMLINK_NAME}@${size}.svg"
		done
		;;
	apps|ap*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48' '64x64'; do
			ln -sfv "$TARGET_ICON" \
				"$_PAPIRUS_DIR/apps/${SYMLINK_NAME}@${size}.svg"
		done
		;;
	devices|d*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48' '64x64'; do
			ln -sfv "$TARGET_ICON" \
				"$_PAPIRUS_DIR/devices/${SYMLINK_NAME}@${size}.svg"
		done
		;;
	emblems|e*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48'; do
			ln -sfv "$TARGET_ICON" \
				"$_PAPIRUS_DIR/emblems/${SYMLINK_NAME}@${size}.svg"
		done
		;;
	mimetypes|m*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48' '64x64'; do
			ln -sfv "$TARGET_ICON" \
				"$_PAPIRUS_DIR/mimetypes/${SYMLINK_NAME}@${size}.svg"
		done
		;;
	panel|pa*)
		for size in '22x22' '24x24'; do
			ln -sfv "$TARGET_ICON" \
				"$_PAPIRUS_DIR/panel/${SYMLINK_NAME}@${size}.svg"
		done
		;;
	places|pl*)
		for size in '16x16' '22x22' '24x24' '32x32' '48x48' '64x64'; do
			ln -sfv "$TARGET_ICON" \
				"$_PAPIRUS_DIR/places/${SYMLINK_NAME}@${size}.svg"
		done
		;;
	status|s*)
		for size in '22x22' '24x24' '32x32' '48x48'; do
			ln -sfv "$TARGET_ICON" \
				"$_PAPIRUS_DIR/status/${SYMLINK_NAME}@${size}.svg"
		done
		;;
	*)
		usage
		;;
esac
