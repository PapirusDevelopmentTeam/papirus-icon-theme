#!/usr/bin/env bash
#
# This script copies needed icons from Papirus to derived themes
# and changes their color schemes

set -eo pipefail

readonly SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
readonly SOURCE_DIR="$SCRIPT_DIR/Papirus"
readonly THEMES_DIR="$SCRIPT_DIR/../.."

mapfile -t THEMES < <(
	find "$THEMES_DIR" -type f -name 'index.theme' -exec dirname '{}' +
)

for theme in "${THEMES[@]##*/}"; do
	theme_dir="$SCRIPT_DIR/$theme"

	case "$theme" in
		ePapirus)
			# copy files and symlinks
			find "$SOURCE_DIR" -maxdepth 1 -type d | while read -r dir; do
				context_dir=$(basename "$dir")

				case "$context_dir" in
					actions)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@16x16.svg' -print0 -o \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
					animations)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
					devices|places)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@16x16.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
					panel)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
				esac
			done

			# convert color scheme
			find "$theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#6e6e6e/gI' \
				-e 's/#d3dae3/#ffffff/gI' '{}' \;
			;;
		Papirus-Dark)
			# copy files and symlinks
			find "$SOURCE_DIR" -maxdepth 1 -type d | while read -r dir; do
				context_dir=$(basename "$dir")

				case "$context_dir" in
					actions)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@16x16.svg' -print0 -o \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 -o \
							-name '*@symbolic.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
					animations)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
					devices|places)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@16x16.svg' -print0 -o \
							-name '*@symbolic.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
					apps|categories|emblems|emotes|mimetypes|status)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@symbolic.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
				esac
			done

			# convert color scheme
			find "$theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#d3dae3/gI' '{}' \;
			;;
		Papirus-Light)
			# copy files and symlinks
			find "$SOURCE_DIR" -maxdepth 1 -type d | while read -r dir; do
				context_dir=$(basename "$dir")

				case "$context_dir" in
					actions)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@16x16.svg' -print0 -o \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
					animations)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
					devices|places)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@16x16.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
					panel)
						mkdir -p "$theme_dir/$context_dir"
						find "$SOURCE_DIR/$context_dir" \
							-name '*@16x16.svg' -print0 -o \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -afv '{}' "$theme_dir/$context_dir"
						;;
				esac
			done

			# convert color scheme
			find "$theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#31363b/gI' \
				-e 's/#5294e2/#3daee9/gI' \
				-e 's/#d3dae3/#31363b/gI' '{}' \;
			;;
		*)
			continue
			;;
	esac
done
