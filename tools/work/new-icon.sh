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

has_symbolic_suffix() {
	local icon_name="$1"

	case "$icon_name" in
		*-symbolic.svg|*-symbolic|*-symbolic-rtl.svg|*-symbolic-rtl)
			return 0
			;;
		*)
			return 1
			;;
	esac
}

readonly _CONTEXT="$1"

[ "$#" -ge 2 ] || usage

shift 1

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

for icon in "$@"; do
	icon_name="$(remove_file_extention "$icon")"

	if has_symbolic_suffix "$icon_name"; then
		SIZES=( '16x16' '22x22' '24x24' )
	fi

	for size in "${SIZES[@]}"; do

		if has_symbolic_suffix "$icon_name"; then
			template_file="${TARGET_DIR}/actions/_TEMPLATE@${size}.SVG"
		else
			template_file="${TARGET_DIR}/${CONTEXT_DIR}/_TEMPLATE@${size}.SVG"
		fi

		cp -v "$template_file" \
			"${TARGET_DIR}/${CONTEXT_DIR}/${icon_name}@${size}.svg"
	done
done

exit 0
