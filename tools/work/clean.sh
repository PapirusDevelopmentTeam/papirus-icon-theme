#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname "$0")

find "$SCRIPT_DIR/ePapirus" "$SCRIPT_DIR/Papirus" "$SCRIPT_DIR/Papirus-Dark" \
	-type f -name '*.svg' -print

echo -n "Do you want to delete the files? [y/N]: "; read REPLY

case "$REPLY" in
	[Yy]*)
		find "$SCRIPT_DIR/ePapirus" "$SCRIPT_DIR/Papirus" "$SCRIPT_DIR/Papirus-Dark" \
			-type f -name '*.svg' -delete
		;;
	*)
		echo "Abort."
		;;
esac
