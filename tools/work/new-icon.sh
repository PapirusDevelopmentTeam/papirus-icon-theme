#!/usr/bin/env bash
#
# This script creates new SVG files from templates

set -eo pipefail

readonly SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
readonly TARGET_DIR="$SCRIPT_DIR/Papirus"

usage() {
	cat <<-EOF
	This script creates new SVG files from templates.

	Usage:
	  $0 context [icon name]

	  available contexts:
	    [ac]tions
	    [ap]ps
	    [d]evices
	    [emb]lems
	    [emo]tes
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
		emblems|emb*)
			CONTEXT="emblems"
			SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' )
			;;
		emotes|emo*)
			CONTEXT="emotes"
			SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' )
			;;
		mimetypes|m*)
			CONTEXT="mimetypes"
			SIZES=( '16x16' '22x22' '24x24' '32x32' '48x48' '64x64' )
			;;
		panel|pa*)
			CONTEXT="panel"
			SIZES=( '16x16' '22x22' '24x24' )
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

readonly RAW_CONTEXT="$1"
declare -a ARGS=("${@:2}")

[ "${#ARGS[@]}" -gt 0 ] || usage

eval "$(_get_context "$RAW_CONTEXT")" || usage

for i in "${ARGS[@]}"; do
	icon_name="$(_get_icon_name "$i")"

	for size in "${SIZES[@]}"; do
		cp -v "${TARGET_DIR}/${CONTEXT}/_TEMPLATE@${size}.SVG" \
			"${TARGET_DIR}/${CONTEXT}/${icon_name}@${size}.svg"
	done
done

exit 0
