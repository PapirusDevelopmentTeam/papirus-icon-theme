#!/usr/bin/env bash
# This script copies icons from the main theme to the directory

set -eo pipefail

SCRIPT_DIR=$(dirname "$0")
TARGET_DIR="$SCRIPT_DIR/../.."

case "$1" in
	all)          CONTEXT_DIR="/"           ;;
	actions|ac*)  CONTEXT_DIR="/actions/"   ;;
	apps|ap*)     CONTEXT_DIR="/apps/"      ;;
	devices|d*)   CONTEXT_DIR="/devices/"   ;;
	emblems|e*)   CONTEXT_DIR="/emblems/"   ;;
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
		    [e]mblems
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

find "$TARGET_DIR/Papirus" -type f -name '*.svg' | grep "$CONTEXT_DIR" | \
	grep -i "${2:?PATTERN not set!}" | while read file; do

	src_dir=$(dirname "$file")
	top_dir=$(dirname "$src_dir")

	base_dir=$(basename "$(dirname "$top_dir")")
	size=$(basename "$top_dir")
	context=$(basename "$src_dir")
	filename=$(basename --suffix=".svg" "$file")

	mkdir -p "$SCRIPT_DIR/$base_dir/$context/"
	cp -v "$file" "$SCRIPT_DIR/$base_dir/$context/$filename@$size.svg"
done
