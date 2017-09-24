#!/usr/bin/env bash
#
# This script creates new symlinks to existing icons

set -eo pipefail

SCRIPT_DIR="$(dirname "$0")"
TARGET_DIR="$SCRIPT_DIR/Papirus"

usage() {
	cat <<-EOF
	This script creates new symlinks to existing icons.

	Usage:
	  $0 context <icon name> <symlink name>...

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
	  $0 apps radiotray.svg radiotray-ng-on.svg
	  $0 panel radiotray_off.svg radiotray-ng-off-panel.svg
	  $0 panel radiotray_on.svg radiotray-ng-on-panel.svg
	EOF

	exit 2
}

_get_icon_name() {
	local icon_name="$1"

	case "$icon_name" in
		*.svg|*.png|*.xpm)
			echo "${icon_name%.*}"
			return 0
			;;
		*)
			echo "${icon_name}"
			return 0
			;;
	esac

	return 1
}

_get_context() {
	local CONTEXT
	local -a SIZES

	case "$1" in
		actions|ac*)
			CONTEXT="actions"
			SIZES=( '16x16' '22x22' '24x24' )
			;;
		apps|ap*)
			CONTEXT="apps"
			SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' '64x64' )
			;;
		devices|d*)
			CONTEXT="devices"
			SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' '64x64' )
			;;
		emblems|e*)
			CONTEXT="emblems"
			SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' )
			;;
		mimetypes|m*)
			CONTEXT="mimetypes"
			SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' '64x64' )
			;;
		panel|pa*)
			CONTEXT="panel"
			SIZES=( '22x22' '24x24' )
			;;
		places|pl*)
			CONTEXT="places"
			SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' '64x64' )
			;;
		status|s*)
			CONTEXT="status"
			SIZES=( '22x22' '24x24' '32x32' '48x48' )
			;;
		*)
			printf "illegal context -- '%s'\n" "$1" >&2
			printf false
			return 1
			;;
	esac

	declare -p CONTEXT SIZES
}

readonly RAW_CONTEXT="$1"; shift
readonly TARGET_ICON="$1"; shift
declare -a ARGS=("$@")

[ -n "$1" ] || usage

eval "$(_get_context "$RAW_CONTEXT")" || usage

for i in "${ARGS[@]}"; do
	symlink_name="$(_get_icon_name "$i")"

	for size in "${SIZES[@]}"; do
		ln -sfv "$TARGET_ICON" \
			"${TARGET_DIR}/${CONTEXT}/${symlink_name}@${size}.svg"
	done
done

exit 0
