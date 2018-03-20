#!/bin/bash

# Uses luminosity.
# color
greyscale() {
    old="$1"
    red="$( echo "$(( 16#${old:1:2} ))*0.299" | bc )"
    green="$( echo "$(( 16#${old:3:2} ))*0.587" | bc)"
    blue="$( echo "$(( 16#${old:5:2} ))*0.114" | bc )"
    result="$( echo "$red + $green + $blue" | bc )"
    #big_result="$( echo "$(( 16#${old:1:2} ))*0.299 + $(( 16#${old:3:2} ))*0.587 + $(( 16#${old:5:2} ))*0.114" | bc )"
    hex="$(printf '%02x\n' "${result%.*}" )"
    #echo "# $red $green $blue -> $result -> $hex -> #${hex}${hex}${hex}"
    echo "#${hex}${hex}${hex}"
}

# file old_color new_color
replace_color() {
    sed -i "s/${2}/${3}/" "${1}"
}

echo "> Duplicating Papirus/ folder into Papirus-Grey/ ..."
#cp Papirus/64x64/apps/signal-desktop.svg ./Papirus-Grey/
#rm -rf Papirus-Grey/
mkdir -p Papirus-Grey/
cp -R Papirus/* Papirus-Grey/

echo "> Locating SVG's ..."
find Papirus-Grey/ -name "*.svg" -type f > convert_list

i=1
max="$(cat convert_list | wc -l)"
echo "> Converting to greyscale ..."
while read -r line; do
    echo "Converting $line ... ($i of $max)"
    grep -Eio "#[0-9a-f]{6}" "$line" > embedded_colors

    while read -r color; do
        replace_color "$line" "$color" "$(greyscale "$color")"
    done < "embedded_colors"

    i="$(( i + 1 ))"
    #inkscape -f "$line" -z --verb EditSelectAll --verb org.inkscape.color.desaturate.noprefs --verb FileSave --verb FileQuit
done < "convert_list"

echo "> Conversion complete, deleting SVG file cache ..."
#rm convert_list embedded_colors


