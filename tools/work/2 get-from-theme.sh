#!/usr/bin/env bash
#
# This script copies icons from the main theme to the directory

set -eo pipefail

readonly SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
readonly SOURCE_DIR="$SCRIPT_DIR/../.."

case "$1" in
	all)          CONTEXT_DIR="/"           ;;
	actions|ac*)  CONTEXT_DIR="/actions/"   ;;
	apps|ap*)     CONTEXT_DIR="/apps/"      ;;
	devices|d*)   CONTEXT_DIR="/devices/"   ;;
	emblems|emb*) CONTEXT_DIR="/emblems/"   ;;
	emotes|emo*)  CONTEXT_DIR="/emotes/"    ;;
	mimetypes|m*) CONTEXT_DIR="/mimetypes/" ;;
	panel|pa*)    CONTEXT_DIR="/panel/"     ;;
	places|pl*)   CONTEXT_DIR="/places/"    ;;
	status|st*)   CONTEXT_DIR="/status/"    ;;
	*)
		cat <<-EOF
		This script copies icons from the main theme to the directory.

		Usage:
		  $0 context PATTERN

		  available contexts:
		    all
		    [ac]tions
		    [ap]ps
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

find "$SOURCE_DIR/Papirus" -type f -name '*.svg' | grep "$CONTEXT_DIR" | \
	grep -i "${2:?PATTERN not set!}" | while read -r file; do

	src_dir=$(dirname "$file")
	top_dir=$(dirname "$src_dir")

	base_dir=$(basename "$(dirname "$top_dir")")
	size=$(basename "$top_dir")
	context=$(basename "$src_dir")
	filename=$(basename "$file" .svg)

	mkdir -p "$SCRIPT_DIR/$base_dir/$context/"
	cp -v "$file" "$SCRIPT_DIR/$base_dir/$context/$filename@$size.svg"
done
