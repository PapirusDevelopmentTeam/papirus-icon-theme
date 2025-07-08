#!/usr/bin/env bash
#
# This script copies icons from the main theme to the directory

set -eo pipefail

readonly SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
readonly SOURCE_DIR="$SCRIPT_DIR/../.."

case "$1" in
	all)            CONTEXT_DIR=""           ;;
	actions|ac*)    CONTEXT_DIR="actions"    ;;
	animations|an*) CONTEXT_DIR="animations" ;;
	apps|ap*)       CONTEXT_DIR="apps"       ;;
	categories|ca*) CONTEXT_DIR="categories" ;;
	devices|d*)     CONTEXT_DIR="devices"    ;;
	emblems|emb*)   CONTEXT_DIR="emblems"    ;;
	emotes|emo*)    CONTEXT_DIR="emotes"     ;;
	mimetypes|m*)   CONTEXT_DIR="mimetypes"  ;;
	panel|pa*)      CONTEXT_DIR="panel"      ;;
	places|pl*)     CONTEXT_DIR="places"     ;;
	status|st*)     CONTEXT_DIR="status"     ;;
	*)
		cat <<-EOF
		This script copies icons from the main theme to the directory.

		Usage:
		  $0 context PATTERN

		  available contexts:
		    all
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
		    [st]atus

		Examples:
		  $0 apps clementine.svg
		  $0 panel mumble-indicator.svg
		  $0 mime text-x-ruby.svg
		EOF

		exit 2
		;;
esac

find "$SOURCE_DIR/Papirus" -type f -regextype posix-extended \
	-iregex ".*/$CONTEXT_DIR/.*${2:?PATTERN not set!}.*" | \
	while read -r file; do

	# Extract theme_dir, size_dir, symbolic_dir, context_dir, and icon name
	if [[ $file =~ .*/([^/]+)/([0-9x@]+)(/symbolic)?/([^/]+)/([^/]+\.svg) ]]; then
		theme_dir="${BASH_REMATCH[1]}"
		size_dir="${BASH_REMATCH[2]}"
		context_dir="${BASH_REMATCH[-2]}"
		icon_name="${BASH_REMATCH[-1]%.svg}"
	fi

	mkdir -p "$SCRIPT_DIR/$theme_dir/$context_dir/"
	cp -v "$file" "$SCRIPT_DIR/$theme_dir/$context_dir/$icon_name@$size_dir.svg"
done
