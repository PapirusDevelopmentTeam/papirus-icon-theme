#!/usr/bin/env bash
# This script creates colored folder icons
#
# Colors of the folder icon:
#
#   @ - primary color
#   . - secondary color
#   " - color of symbol
#   * - color of paper
#
#    ..................
#    ..................
#    ........................................
#    ..************************************..
#    ..************************************..
#    ..************************************..
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@""""@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@""""@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@""""@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@""""@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@""""""""""""@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@""""""""""@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@""""""@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@""@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@""""""""""""@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

set -eo pipefail

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
TARGET_DIR="$SCRIPT_DIR/../Papirus"

DEFAULT_COLOR="blue"
SIZES_REGEX="(16x16|22x22|24x24|32x32|48x48|64x64)"
COLOR_SIZES_REGEX="(22x22|24x24|32x32|48x48|64x64)"
FILES_REGEX="(folder|user)-"

declare -A COLORS

COLORS=(
	# [0] - primary color
	# [1] - secondary color
	# [2] - color of symbol
	# [3] - color of paper
	#
	# | name     | [0]   | [1]   | [2]   | [3]   |
	# |----------|-------|-------|-------|-------|
	[blue]="      #5294e2 #4877b1 #1d344f #e4e4e4"
	[black]="     #4f4f4f #3f3f3f #c2c2c2 #dcdcdc"
	[bluegrey]="  #607d8b #4d646f #222c31 #e4e4e4"
	[brown]="     #ae8e6c #957552 #3d3226 #e4e4e4"
	[cyan]="      #00bcd4 #0096aa #00424a #e4e4e4"
	[deeporange]="#eb6637 #e95420 #522413 #e4e4e4"
	[green]="     #87b158 #60924b #2f3e1f #e4e4e4"
	[grey]="      #8e8e8e #727272 #323232 #e4e4e4"
	[indigo]="    #5c6bc0 #3f51b5 #202543 #e4e4e4"
	[magenta]="   #ca71df #b259b8 #47274e #e4e4e4"
	[orange]="    #ee923a #dd772f #533314 #e4e4e4"
	[pink]="      #f06292 #ec407a #542233 #e4e4e4"
	[red]="       #e25252 #bf4b4b #4f1d1d #e4e4e4"
	[teal]="      #16a085 #12806a #08382e #e4e4e4"
	[violet]="    #7e57c2 #5d399b #2c1e44 #e4e4e4"
	[white]="     #e4e4e4 #cccccc #4f4f4f #ffffff"
	[yellow]="    #e2b322 #b58f1b #4f3e0c #e4e4e4"
	[nordic]="    #82abaa #6c9b9a #4e6766 #e4e4e4"
	[custom]="    #value_light #value_dark #323232 #e4e4e4"
)


headline() {
	printf "%b => %b%s\n" "\e[1;32m" "\e[0m" "$*"
}

msg() {
	printf "%b [+] %b%s\n" "\e[1;33m" "\e[0m" "$*"
}

recolor() {
	# args: <old colors> <new colors> <path to file>
	IFS=" " read -ra old_colors <<< "$1"
	IFS=" " read -ra new_colors <<< "$2"
	local filepath="$3"

	[ -f "$filepath" ] || exit 1

	for (( i = "${#old_colors[@]}" - 1; i >= 0; i-- )); do
		sed -i "s/${old_colors[$i]}/${new_colors[$i]}/gI" "$filepath"
	done
}

headline "PHASE 1: Delete color suffix from monochrome icons ..."
# -----------------------------------------------------------------------------
find "$TARGET_DIR" -regextype posix-extended \
	-regex ".*/16x16/places/${FILES_REGEX}${DEFAULT_COLOR}-.*" \
	-print0 | while read -r -d $'\0' file; do

	new_file="${file/-$DEFAULT_COLOR-/-}"

	msg "'$file' is renamed to '$new_file'"
	mv -f "$file" "$new_file"
done


headline "PHASE 2: Create missing symlinks ..."
# -----------------------------------------------------------------------------
find "$TARGET_DIR" -type f -regextype posix-extended \
	-regex ".*/${COLOR_SIZES_REGEX}/places/${FILES_REGEX}${DEFAULT_COLOR}[-\.].*" \
	-print0 | while read -r -d $'\0' file; do

	target="$(basename "$file")"
	symlink="${file/-$DEFAULT_COLOR/}"

	[ -e "$symlink" ] && continue

	msg "Creating missing symlink '$symlink' ..."
	ln -sf "$target" "$symlink"
done


headline "PHASE 3: Generate color folders ..."
# -----------------------------------------------------------------------------
find "$TARGET_DIR" -type f -regextype posix-extended \
	-regex ".*/${SIZES_REGEX}/places/${FILES_REGEX}${DEFAULT_COLOR}[-\.].*" \
	-print0 | while read -r -d $'\0' file; do

	for color in "${!COLORS[@]}"; do
		[[ "$color" != "$DEFAULT_COLOR" ]] || continue

		new_file="${file/-$DEFAULT_COLOR/-$color}"

		cp -P --remove-destination "$file" "$new_file"
		recolor "${COLORS[$DEFAULT_COLOR]}" "${COLORS[$color]}" "$new_file"
	done
done


headline "PHASE 4: Create symlinks for Folder Color v0.0.80 and newer ..."
# -----------------------------------------------------------------------------
# Icons mapping
FOLDER_COLOR_MAP=(
	# Folder Color icon         | Papirus icon
	# --------------------------|---------------------------
	"folder-COLOR-desktop.svg    user-COLOR-desktop.svg"
	"folder-COLOR-downloads.svg  folder-COLOR-download.svg"
	"folder-COLOR-public.svg     folder-COLOR-image-people.svg"
	"folder-COLOR-videos.svg     folder-COLOR-video.svg"
)

for mask in "${FOLDER_COLOR_MAP[@]}"; do
	for color in "${!COLORS[@]}"; do
		IFS=" " read -ra icon_mask <<< "$mask"
		folder_color_icon="${icon_mask[0]/COLOR/$color}"
		icon="${icon_mask[1]/COLOR/$color}"

		find "$TARGET_DIR" -regextype posix-extended \
			-regex ".*/${SIZES_REGEX}/places/${icon}" \
			-print0 | while read -r -d $'\0' file; do

			base_name="$(basename "$file")"
			dir_name="$(dirname "$file")"

			ln -sf "$base_name" "$dir_name/$folder_color_icon"
		done
	done
done


headline "PHASE 5: Copy color folder icons to derivative themes ..."
# -----------------------------------------------------------------------------
COLOR_NAMES="${!COLORS[*]}"  # get a string of colors
COLOR_REGEX="(${COLOR_NAMES// /|})"  # convert the list of colors to regex
DERIVATIVES=(
	ePapirus
	Papirus-Dark
)  # array of derivative icon themes with 16x16 places

find "$TARGET_DIR" -regextype posix-extended \
	-regex ".*/16x16/places/folder-${COLOR_REGEX}.*" \
	-print0 | while read -r -d $'\0' file; do

	for d in "${DERIVATIVES[@]}"; do
		cp -P --remove-destination "$file" "${file/Papirus/$d}"
	done
done
