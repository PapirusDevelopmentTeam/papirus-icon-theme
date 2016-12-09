#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
_PAPIRUS_DIR="$SCRIPT_DIR/Papirus"
_PAPIRUS_DARK_DIR="$SCRIPT_DIR/Papirus-Dark"

find "$_PAPIRUS_DIR" "$_PAPIRUS_DARK_DIR" -type f -name '*.svg' -print

echo -n "Do you want to delete the files? [y/N]: "; read REPLY

case "$REPLY" in
	[Yy]*)
		find "$_PAPIRUS_DIR" "$_PAPIRUS_DARK_DIR" -type f -name '*.svg' -delete
		;;
	*)
		echo "Abort."
		;;
esac
