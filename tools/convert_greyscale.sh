#!/bin/bash

# Usage:
# convert_greyscale.sh SOURCE NAME DESC RED GREEN BLUE
# convert_greyscale.sh Papirus Papirus-Grey "A minimalist, greyscale icon theme" 0.299 0.587 0.114

SCRIPT_DIR="$(dirname "$0")"
SOURCE_NAME="${1:-Papirus}"
THEME_NAME="${2:-Papirus-Grey}"
TARGET_DIR="$SCRIPT_DIR/../${THEME_NAME}"
THEME_DESC="${3:-A minimalist, greyscale icon theme }"

RED_LUMINOSITY="${4:-0.299}"
GREEN_LUMINOSITY="${5:-0.587}"
BLUE_LUMINOSITY="${6:-0.114}"

# Temporary files for storing caches of filenames and hexes.
# Append the theme name in case we want to run multiple theme builders in
# parallel.
CONVERT_LIST=".convert_list_${THEME_NAME}"
EMBEDDED_COLORS=".embedded_colors_${THEME_NAME}"

# Computes greyscale using luminosity.
# greyscale(color)
greyscale() {
    old="$1"

    red="$( echo "$(( 16#${old:1:2} ))*${RED_LUMINOSITY}" | bc )"
    green="$( echo "$(( 16#${old:3:2} ))*${GREEN_LUMINOSITY}" | bc)"
    blue="$( echo "$(( 16#${old:5:2} ))*${BLUE_LUMINOSITY}" | bc )"

    result="$( echo "$red + $green + $blue" | bc )"
    hex="$(printf '%02x\n' "${result%.*}" )"

    echo "#${hex}${hex}${hex}"
}

# Replaces a hex code in a file with a new one.
# replace_color(file old_color new_color)
replace_color() {
    sed -i "s/${2}/${3}/" "${1}"
}

echo "> Duplicating ${SOURCE_NAME} into ${THEME_NAME} ..."
rm -rf "${TARGET_DIR}"
#mkdir -p "${TARGET_DIR}"
cp -R "$SCRIPT_DIR/../${SOURCE_NAME}" "${TARGET_DIR}"

echo "> Updating metadata ..."
sed -i "s/Name=.*/Name=${THEME_NAME}/" "${TARGET_DIR}/index.theme"
sed -i "s/Comment=.*/Comment=${THEME_DESC}/" "${TARGET_DIR}/index.theme"

echo "> Locating SVG's ..."
# Only get the _actual_ SVG files. Skip symlinks (-type f).
find "${TARGET_DIR}" -name "*.svg" -type f > "${CONVERT_LIST}"

i=1
max="$(cat "${CONVERT_LIST}" | wc -l)"
echo "> Converting to greyscale ..."
while read -r line; do
    echo "Converting $line ... ($i of $max)"

    # Grab all of the existing hex codes.
    grep -Eio "#[0-9a-f]{6}" "$line" > "${EMBEDDED_COLORS}"

    # Replace them one by one.
    while read -r color; do
        replace_color "$line" "$color" "$(greyscale "$color")"
    done < "${EMBEDDED_COLORS}"

    i="$(( i + 1 ))"

    # The excruciatingly slow, GUI method ...
    #inkscape -f "$line" -z --verb EditSelectAll --verb org.inkscape.color.desaturate.noprefs --verb FileSave --verb FileQuit
done < "${CONVERT_LIST}"

echo "> Conversion complete, deleting SVG file cache ..."
rm "${CONVERT_LIST}" "${EMBEDDED_COLORS}"
