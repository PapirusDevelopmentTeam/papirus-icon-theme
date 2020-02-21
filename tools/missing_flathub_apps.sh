#!/usr/bin/env bash
#
# Before running this script make sure that Flathub repo is added:
#
# flatpak remote-add --user --if-not-exists \
#     flathub https://flathub.org/repo/flathub.flatpakrepo

set -euo pipefail

IFS=$'\n\t'
SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
GIT_ROOT="$SCRIPT_DIR/.."

IGNORED_APPS=(
	# apps without icons:
	io.atom.electron.BaseApp
	io.elementary.BaseApp
	io.elementary.Loki.BaseApp
	io.gitlab.sdl_jstest.sdl2_jstest
	io.gitlab.sdl_jstest.sdl_jstest
	io.qt.qtwebengine.BaseApp
	io.qt.qtwebkit.BaseApp
	org.electronjs.Electron2.BaseApp
	org.flathub.flatpak-external-data-checker
	org.flatpak.Builder
	org.freedesktop.appstream-glib
	org.freedesktop.GlxInfo
	org.godotengine.godot.BaseApp
	org.mosh.mosh
	org.mozilla.Firefox.BaseApp
	# apps with icons that do not match with App ID:
	com.github.utsushi.Utsushi
	com.wps.Office
	net.openra.OpenRA
	org.homelinuxserver.vance.biblereader
	org.libreoffice.LibreOffice
	org.vranki.spectral
)

flathub_apps_list="$(mktemp -u)"
papirus_icons_list="$(mktemp -u)"

_cleanup() {
	rm -f "$flathub_apps_list" "$papirus_icons_list"
}

trap _cleanup EXIT HUP INT TERM

env XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share" \
	flatpak remote-ls --app --columns app flathub | sort -u > "$flathub_apps_list"
git -C "$GIT_ROOT" ls-tree master:Papirus/64x64/apps --name-only |
	sed 's/\.svg$//' | sort > "$papirus_icons_list"

while read -r app_id; do
	[[ "${IGNORED_APPS[*]//$app_id/}" == "${IGNORED_APPS[*]}" ]] || continue
	if [ -n "${MARKDOWN:-}" ]; then
		# shellcheck disable=SC2016
		printf ' - [ ] `%s` <kbd>[GitHub](%s)</kbd> <kbd>[Flathub](%s)</kbd>\n' "$app_id" \
			"https://github.com/flathub/$app_id" "https://flathub.org/apps/details/$app_id"
	else
		printf '%s\n' "$app_id"
	fi
done < <(comm -23 "$flathub_apps_list" "$papirus_icons_list")
