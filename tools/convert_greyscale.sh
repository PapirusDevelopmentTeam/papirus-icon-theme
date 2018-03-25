#!/bin/bash

# Usage:
# convert_greyscale.sh SOURCE TARGET RED GREEN BLUE
# convert_greyscale.sh Papirus Papirus-Grey 0.299 0.587 0.114

SCRIPT_DIR="$(dirname "$0")"
SOURCE_NAME="${1:-Papirus}"
THEME_NAME="${2:-Papirus-Grey}"
TARGET_DIR="$SCRIPT_DIR/../${THEME_NAME}/"

RED_LUMINOSITY="${3:-0.299}"
GREEN_LUMINOSITY="${4:-0.587}"
BLUE_LUMINOSITY="${5:-0.114}"

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

echo "> Duplicating ${SOURCE_NAME} into ${TARGET_NAME} ..."
#rm -rf Papirus-Grey/
mkdir -p "${TARGET_DIR}"
cp -R "$SCRIPT_DIR/../${SOURCE_NAME}/*" "${TARGET_DIR}"

echo "> Locating SVG's ..."
find "${TARGET_DIR}" -name "*.svg" -type f > ".convert_list"

i=1
max="$(cat convert_list | wc -l)"
echo "> Converting to greyscale ..."
while read -r line; do
    echo "Converting $line ... ($i of $max)"
    grep -Eio "#[0-9a-f]{6}" "$line" > ".embedded_colors"

    while read -r color; do
        replace_color "$line" "$color" "$(greyscale "$color")"
    done < ".embedded_colors"

    i="$(( i + 1 ))"

    # The excruciatingly slow, GUI method ...
    #inkscape -f "$line" -z --verb EditSelectAll --verb org.inkscape.color.desaturate.noprefs --verb FileSave --verb FileQuit
done < ".convert_list"

echo "> Conversion complete, deleting SVG file cache ..."
rm ".convert_list" ".embedded_colors"
