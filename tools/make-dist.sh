#!/usr/bin/env bash

set -euo pipefail

PACKAGE_PREFIX="papirus-icon-theme"
ARCHIVE_EXT="tar.gz"
export XZ_OPT="-3 -e -T0"

PROGNAME="$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
GIT_ROOT="$(realpath "$SCRIPT_DIR/..")"
BUILD_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/papirus-dist"

if ! command -v papirus-folders >/dev/null; then
	echo "papirus-folders script is not installed. Install it first." >&2
	exit 1
fi

usage() {
	cat <<- EOF
	This script create archives for all available folders colors for uploading to
	https://www.opendesktop.org

	USAGE
	  $ $PROGNAME [-f EXT] [-v VERSION] [COLOR1 [COLOR2] [COLOR3] ..]

	OPTIONS
	  -f EXTENTION  format of the resulting archives (Default: $ARCHIVE_EXT)
	  -v VERSION    existing git tag or branch name (Default: last release)
	  -t            use tmpfs instead of ${XDG_CACHE_HOME:-$HOME/.cache}
	  -h            show this help

	EXAMPLES
	  $ $PROGNAME     # create archives for the last release for all available colors
	  $ $PROGNAME ""  # create archives for the last release without folder colors
	  $ $PROGNAME -f tar.xz -v 20211001
	  $ $PROGNAME -f tar.xz -v master red green bluegrey
	EOF

	exit "${1:-0}"
}

while getopts ":hf:tv:" opt; do
	case "$opt" in
	h)
		usage 0
		;;
	f)
		ARCHIVE_EXT="${OPTARG#.}"
		;;
	t)
		BUILD_DIR="$(mktemp -u --tmpdir papirus-dist.XXXXXX)"
		;;
	v)
		VERSION="$OPTARG"
		;;
	:)
		echo "Error: option -$OPTARG requires an argument" >&2
		usage 2
		;;
	\?)
		echo "Invalid option: -$OPTARG" >&2
		usage 2
		;;
	esac
done

shift $((OPTIND-1))

mapfile -t ICON_THEMES < <(
	find "$GIT_ROOT" -type f -name 'index.theme' -printf '%h\n'
)

if [ -z "${VERSION:-}" ]; then
	VERSION="$(git -C "$GIT_ROOT" tag -l --sort=-version:refname | head -1)"
fi

echo "Start creating archives for $VERSION version"

CORE_PACKAGE="$PACKAGE_PREFIX-$VERSION.tar.gz"

if [ -s "$GIT_ROOT/$CORE_PACKAGE" ]; then
	echo "'$GIT_ROOT/$CORE_PACKAGE' already exists. Skipping ..."
else
	git -C "$GIT_ROOT" archive --format=tar.gz \
		-o "$CORE_PACKAGE" "$VERSION" -- \
		"${ICON_THEMES[@]##*/}"
fi

if [ -e "$BUILD_DIR" ]; then
	echo "Remove '$BUILD_DIR' ..."
	rm -r "${BUILD_DIR?}"
fi

mkdir -p "$BUILD_DIR"

echo "Extracting '$GIT_ROOT/$CORE_PACKAGE' to '$BUILD_DIR' ..."
tar -C "$BUILD_DIR" -xzf "$GIT_ROOT/$CORE_PACKAGE"

cd "$BUILD_DIR"

if [ "$#" -gt 0 ]; then
	FOLDER_COLORS=("$@")
else
	# Get array of folders colors without the default color
	mapfile -t FOLDER_COLORS < <(papirus-folders -l | sed -e '/>/d' -e 's/[ ]\+//g')
fi

for color in "${FOLDER_COLORS[@]}"; do
	[ -n "$color" ] || break

	package_file="$GIT_ROOT/$PACKAGE_PREFIX-$color-folders.$ARCHIVE_EXT"

	if [ -s "$package_file" ]; then
		echo "'$package_file' already exists. Skipping ..."
		continue
	fi

	# change folder color
	DISABLE_UPDATE_ICON_CACHE=1 papirus-folders --once --color "$color"

	echo "Creating '$package_file' ..."
	tar -caf "$package_file" "${ICON_THEMES[@]##*/}"
done

if [ -e "$BUILD_DIR" ]; then
	echo "Cleanup '$BUILD_DIR' ..."
	rm -r "${BUILD_DIR?}"
fi
