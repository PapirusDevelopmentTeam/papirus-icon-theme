#!/usr/bin/env bash
#
# This script deletes *.svg files from the directory

set -eo pipefail

readonly SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

find "$SCRIPT_DIR" -mindepth 2 -name '*.svg' -print

echo -n "Do you want to delete these files? [y/N]: "; read -r REPLY

case "$REPLY" in
	[Yy]*)
		find "$SCRIPT_DIR" -mindepth 2 -name '*.svg' -delete
		;;
	*)
		echo "Abort."
		;;
esac
