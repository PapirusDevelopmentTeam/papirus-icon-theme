#!/usr/bin/env bash
#
# This script creates new symlinks to existing icons

set -eo pipefail

readonly SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
readonly TARGET_DIR="$SCRIPT_DIR/Papirus"

usage() {
	cat <<-EOF
	This script creates new symlinks to existing icons.

	Usage:
	  $0 context <icon name> <symlink name>...

	  available contexts:
	    [ac]tions
	    [an]imations
	    [ap]ps
	    [ca]tegories
	    [d]evices
	    [emb]lems
	    [emo]tes
	    [m]imetypes
	    [pa]nel
	    [pl]aces
	    [s]tatus

	Examples:
	  $0 apps steam.svg com.valvesoftware.Steam.svg
	  $0 panel indicator-cpufreq.svg cpu-frequency-indicator.svg
	  $0 status ../devices/input-touchpad-symbolic.svg touchpad-enabled-symbolic.svg
	EOF

	exit 2
}

has_symbolic_suffix() {
	local icon_name="$1"

	case "$icon_name" in
		*-symbolic.svg|*-symbolic)
			return 0
			;;
		*)
			return 1
			;;
	esac
}

remove_file_extention() {
	local icon_name="$1"

	case "$icon_name" in
		*.svg|*.png|*.xpm)
			echo "${icon_name%.*}"
			;;
		*)
			echo "${icon_name}"
			;;
	esac
}

readonly _CONTEXT="$1"
readonly TARGET_ICON="$2"

[ "$#" -ge 3 ] || usage

shift 2

CONTEXT_DIR=""
SIZES=()

case "$_CONTEXT" in
	actions|ac*)
		CONTEXT_DIR="actions"
		SIZES=( '16x16' '22x22' '24x24' )
		;;
	animations|an*)
		CONTEXT_DIR="animations"
		SIZES=( '22x22' '24x24' )
		;;
	apps|ap*)
		CONTEXT_DIR="apps"
		SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' '64x64' )
		;;
	categories|ca*)
		CONTEXT_DIR="categories"
		SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' '64x64' )
		;;
	devices|d*)
		CONTEXT_DIR="devices"
		SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' '64x64' )
		;;
	emblems|emb*)
		CONTEXT_DIR="emblems"
		SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' )
		;;
	emotes|emo*)
		CONTEXT_DIR="emotes"
		SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' )
		;;
	mimetypes|m*)
		CONTEXT_DIR="mimetypes"
		SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' '64x64' )
		;;
	panel|pa*)
		CONTEXT_DIR="panel"
		SIZES=( '16x16' '22x22' '24x24' )
		;;
	places|pl*)
		CONTEXT_DIR="places"
		SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' '64x64' )
		;;
	status|s*)
		CONTEXT_DIR="status"
		SIZES=( '22x22' '24x24' '32x32' '48x48' )
		;;
	*)
		printf "illegal context -- '%s'\n" "$1" >&2
		usage
		;;
esac

for symbolic in "$@"; do
	symlink_name="$(remove_file_extention "$symbolic")"

	if has_symbolic_suffix "$symlink_name"; then
		SIZES=( '16x16' '22x22' '24x24' )
	fi

	for size in "${SIZES[@]}"; do
		ln -sfv "$TARGET_ICON" \
			"$TARGET_DIR/$CONTEXT_DIR/${symlink_name}@${size}.svg"
	done
done

exit 0
