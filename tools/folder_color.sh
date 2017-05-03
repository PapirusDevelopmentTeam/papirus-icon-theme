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

FOLDER_COLOR_PREFIX="folder_color"
FOLDER_EXTRA_PREFIX="folder_extraicons"

# Available colors in Papirus
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

# Icons mapping
ICONS_MAP=(
	# 'folder color sufix::papirus icon prefix'
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

EXTRA_ICONS_MAP=(
	# 'folder color sufix::papirus icon prefix'
	'_home::folder-home'
	'_remote::folder-remote'
	'_recent::folder-recent'
)

# Monochrome icons (16px)
MONO_ICONS_MAP=(
	# 'folder color sufix::papirus icon prefix'
	'::folder'
	'_desktop::user-desktop'
	'_documents::folder-documents'
	'_downloads::folder-downloads'
	'_music::folder-sound'
	'_pictures::folder-image'
	'_public::folder-publicshare'
	'_templates::folder-temp'
	'_videos::folder-video'
)

# Extra monochrome icons (16px)
MONO_EXTRA_ICONS_MAP=(
	# 'folder color sufix::papirus icon prefix'
	'_home::user-home'
	'_remote::folder-remote'
	'_recent::folder-recent'
)

ICON_THEMES=(
	ePapirus
	Papirus
	Papirus-Dark
	Papirus-Light
)

SIZES=(
	22
	24
	32
	48
	64
)

# Cleanup
find "$DESTDIR" -name "${FOLDER_COLOR_PREFIX}_*" -not -path '*actions*' -delete
find "$DESTDIR" -name "${FOLDER_EXTRA_PREFIX}_*" -not -path '*actions*' -delete

for size in "${SIZES[@]}"; do
	for icon in "${ICONS_MAP[@]}"; do
		# folder_color icon  -> ${icon%%::*}
		# papirus icon -> ${icon##*::}

		# Default color
		# IMPORTANT:
		#  Folder Color will show your Folder Color Icons if "folder_color_blue.svg" exists.
		ln -sfv "${icon##*::}.svg" \
			"${DESTDIR}/${size}x${size}/places/${FOLDER_COLOR_PREFIX}_blue${icon%%::*}.svg"

		# Another colors
		for color in "${COLORS[@]}"; do
			ln -sfv "${icon##*::}-${color}.svg" \
				"${DESTDIR}/${size}x${size}/places/${FOLDER_COLOR_PREFIX}_${color}${icon%%::*}.svg"
		done
	done

	for extra_icon in "${EXTRA_ICONS_MAP[@]}"; do
		# folder_color icon  -> ${extra_icon%%::*}
		# papirus icon -> ${extra_icon##*::}

		# Default color
		ln -sfv "${icon##*::}.svg" \
			"${DESTDIR}/${size}x${size}/places/${FOLDER_EXTRA_PREFIX}_blue${extra_icon%%::*}.svg"

		# Another colors
		for color in "${COLORS[@]}"; do
			ln -sfv "${extra_icon##*::}-${color}.svg" \
				"${DESTDIR}/${size}x${size}/places/${FOLDER_EXTRA_PREFIX}_${color}${extra_icon%%::*}.svg"
		done
	done
done

# Monochrome icons (16px)
size="16"

for theme in "${ICON_THEMES[@]}"; do
	DESTDIR="${DESTDIR%/*}/${theme}"

	for icon in "${MONO_ICONS_MAP[@]}"; do
		# folder_color icon  -> ${icon%%::*}
		# papirus icon -> ${icon##*::}

		# Default color
		# IMPORTANT:
		#  Folder Color will show your Folder Color Icons if "folder_color_blue.svg" exists.
		ln -sfv "${icon##*::}.svg" \
			"${DESTDIR}/${size}x${size}/places/${FOLDER_COLOR_PREFIX}_blue${icon%%::*}.svg"

		# Another colors
		for color in "${COLORS[@]}"; do
			ln -sfv "${icon##*::}.svg" \
				"${DESTDIR}/${size}x${size}/places/${FOLDER_COLOR_PREFIX}_${color}${icon%%::*}.svg"
		done
	done

	for extra_icon in "${MONO_EXTRA_ICONS_MAP[@]}"; do
		# folder_color icon  -> ${extra_icon%%::*}
		# papirus icon -> ${extra_icon##*::}

		# Default color
		ln -sfv "${icon##*::}.svg" \
			"${DESTDIR}/${size}x${size}/places/${FOLDER_EXTRA_PREFIX}_blue${extra_icon%%::*}.svg"

		# Another colors
		for color in "${COLORS[@]}"; do
			ln -sfv "${extra_icon##*::}.svg" \
				"${DESTDIR}/${size}x${size}/places/${FOLDER_EXTRA_PREFIX}_${color}${extra_icon%%::*}.svg"
		done
	done
done
