#!/usr/bin/env bash
# file: tools/folder_color.sh
#
# Documentation:
#  http://bazaar.launchpad.net/~costales/folder-color/trunk/view/head:/README
#
# EMBLEMS (OPTIONAL)
# IMPORTANT: Folder Color will show your Emblems if the icon "folder_emblem_favorite.svg" exists.
# EMBLEMS_MAP=(
#     folder_emblem_favorite.svg::emblem-favorite.svg
#     folder_emblem_finished.svg::emblem-default.svg
#     folder_emblem_important.svg::emblem-important.svg
#     folder_emblem_in_progress.svg::emblem-pause.svg
# )
#
# CONTEXTUAL MENU ICONS (OPTIONAL)
# ACTIONS_MAP=(
# 	folder_color_globalcolor.svg::configure.svg
# 	folder_color_edit.svg::edit.svg
# 	folder_color_picker.svg::color-picker.svg
# 	folder_color_undo.svg::edit-undo.svg
# )


set -e

DESTDIR="../Papirus"

COLORS=(
	'black'
	'brown'
	'cyan'
	'green'
	'grey'
	'magenta'
	'orange'
	'pink'
	'yellow'
)

ICON_PREFIX="folder_color"

# Icons mapping
ICONS_MAP=(
	# folder_color sufix::papirus icon
	'::folder'
	'_desktop::user-desktop'
	'_documents::folder-documents'
	'_downloads::folder-downloads'
	'_music::folder-sound'
	'_pictures::folder-image'
	'_public::folder-image-people'
	'_templates::folder-temp'
	'_videos::folder-video'
)

EXTRA_ICONS_PREFIX="folder_extraicons"
EXTRA_ICONS_MAP=(
	'_home::folder-home'
	'_remote::folder-remote'
	'_recent::folder-recent'
)


SIZES=(
	22
	24
	32
	48
	64
)

# Cleanup
find "$DESTDIR" -name "${ICON_PREFIX}_*" -not -path '*actions*' -delete
find "$DESTDIR" -name "${EXTRA_ICONS_PREFIX}_*" -not -path '*actions*' -delete

for size in "${SIZES[@]}"; do
	for icon in "${ICONS_MAP[@]}"; do
		# folder_color icon  -> ${icon%%::*}
		# papirus icon -> ${icon##*::}

		# Default color
		# IMPORTANT:
		#  Folder Color will show your Folder Color Icons if "folder_color_blue.svg" exists.
		ln -sfv "${icon##*::}.svg" \
			"${DESTDIR}/${size}x${size}/places/${ICON_PREFIX}_blue${icon%%::*}.svg"

		# Another colors
		for color in "${COLORS[@]}"; do
			ln -sfv "${icon##*::}-${color}.svg" \
				"${DESTDIR}/${size}x${size}/places/${ICON_PREFIX}_${color}${icon%%::*}.svg"
		done
	done

	for extra_icon in "${EXTRA_ICONS_MAP[@]}"; do
		# folder_color icon  -> ${extra_icon%%::*}
		# papirus icon -> ${extra_icon##*::}

		# Default color
		ln -sfv "${icon##*::}.svg" \
			"${DESTDIR}/${size}x${size}/places/${EXTRA_ICONS_PREFIX}_blue${extra_icon%%::*}.svg"

		# Another colors
		for color in "${COLORS[@]}"; do
			ln -sfv "${extra_icon##*::}-${color}.svg" \
				"${DESTDIR}/${size}x${size}/places/${EXTRA_ICONS_PREFIX}_${color}${extra_icon%%::*}.svg"
		done
	done
done
