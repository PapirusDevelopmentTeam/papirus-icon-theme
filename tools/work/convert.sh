#!/usr/bin/env bash
#
# This script copies needed icons from Papirus to derived themes
# and changes their color schemes

set -eo pipefail

SCRIPT_DIR="$(dirname "$0")"
SOURCE_DIR="$SCRIPT_DIR/Papirus"

find "$SCRIPT_DIR" -maxdepth 1 -type d | while read -r theme_dir; do
	theme_name=$(basename "$theme_dir")

	case "$theme_name" in
		ePapirus)
			# copy files from Papirus to ePapirus
			find "$theme_dir" -maxdepth 1 -type d | while read -r dir; do
				sub_dir=$(basename "$dir")

				case "$sub_dir" in
					actions)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@16x16.svg' -print0 -o \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
					devices|places)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@16x16.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
					panel)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
				esac
			done

			# convert color scheme from Papirus to ePapirus
			find "$theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#6e6e6e/gI' \
				-e 's/#d3dae3/#ffffff/gI' '{}' \;
			;;
		Papirus-Adapta)
			# copy files from Papirus to Papirus-Adapta
			find "$theme_dir" -maxdepth 1 -type d | while read -r dir; do
				sub_dir=$(basename "$dir")

				case "$sub_dir" in
					actions)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@16x16.svg' -print0 -o \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
					devices|places)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@16x16.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
					panel)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
				esac
			done

			# convert color scheme from Papirus to Papirus-Adapta
			find "$theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#414c52/gI' \
				-e 's/#d3dae3/#cfd8dc/gI' \
				-e 's/#5294e2/#00bcd4/gI' '{}' \;
			;;
		Papirus-Adapta-Nokto)
			# copy files from Papirus to Papirus-Adapta-Nokto
			find "$theme_dir" -maxdepth 1 -type d | while read -r dir; do
				sub_dir=$(basename "$dir")

				case "$sub_dir" in
					actions)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@16x16.svg' -print0 -o \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
					devices|places)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@16x16.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
				esac
			done

			# convert color scheme from Papirus to Papirus-Adapta-Nokto
			find "$theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#cfd8dc/gI' \
				-e 's/#5294e2/#00bcd4/gI' '{}' \;
			;;
		Papirus-Dark)
			# copy files from Papirus to Papirus-Dark
			find "$theme_dir" -maxdepth 1 -type d | while read -r dir; do
				sub_dir=$(basename "$dir")

				case "$sub_dir" in
					actions)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@16x16.svg' -print0 -o \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 -o \
							-name '*@symbolic.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
					devices|places)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@16x16.svg' -print0 -o \
							-name '*@symbolic.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
					apps|categories|emblems|emotes|mimetypes|status)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@symbolic.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
				esac
			done

			# convert color scheme from Papirus to Papirus-Dark
			find "$theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#d3dae3/gI' '{}' \;
			;;
		Papirus-Light)
			# copy files from Papirus to Papirus-Light
			find "$theme_dir" -maxdepth 1 -type d | while read -r dir; do
				sub_dir=$(basename "$dir")

				case "$sub_dir" in
					panel)
						find "$SOURCE_DIR/$sub_dir" \
							-name '*@22x22.svg' -print0 -o \
							-name '*@24x24.svg' -print0 | xargs -0 -i \
								cp -auv '{}' "$theme_dir/$sub_dir"
						;;
				esac
			done

			# convert color scheme from Papirus to Papirus-Light
			find "$theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#d3dae3/#5c616c/gI' '{}' \;
			;;
		*)
			continue
			;;
	esac
done
