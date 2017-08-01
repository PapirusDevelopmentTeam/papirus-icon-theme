#!/usr/bin/env bash
# This script deletes *.svg files from the directory

set -eo pipefail

SCRIPT_DIR=$(dirname "$0")
SOURCE_DIRS=(
	"$SCRIPT_DIR/ePapirus"
	"$SCRIPT_DIR/Papirus"
	"$SCRIPT_DIR/Papirus-Dark"
	"$SCRIPT_DIR/Papirus-Light"
)

find "${SOURCE_DIRS[@]}" -name '*.svg' -print

echo -n "Do you want to delete these files? [y/N]: "; read REPLY

case "$REPLY" in
	[Yy]*)
		find "${SOURCE_DIRS[@]}" -name '*.svg' -delete
		;;
	*)
		echo "Abort."
		;;
esac
