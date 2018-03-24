#!/bin/bash

# Uses luminosity.
# color
greyscale() {
    old="$1"
    red="$( echo "$(( 16#${old:1:2} ))*0.2126" | bc )"
    green="$( echo "$(( 16#${old:3:2} ))*0.7152" | bc)"
    blue="$( echo "$(( 16#${old:5:2} ))*0.0722" | bc )"
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

echo "> Duplicating Papirus/ folder into Papirus-Greytika/ ..."
#cp Papirus/64x64/apps/signal-desktop.svg ./Papirus-Greytika/
#rm -rf Papirus-Greytika/
mkdir -p Papirus-Greytika/
cp -R Papirus/* Papirus-Greytika/

echo "> Locating SVG's ..."
find Papirus-Greytika/ -name "*.svg" -type f > convert_listtika

i=1
max="$(cat convert_listtika | wc -l)"
echo "> Converting to greyscale greytika ..."
while read -r line; do
    echo "Converting $line ... ($i of $max)"
    grep -Eio "#[0-9a-f]{6}" "$line" > embedded_colorstika

    while read -r color; do
        replace_color "$line" "$color" "$(greyscale "$color")"
    done < "embedded_colorstika"

    i="$(( i + 1 ))"
    #inkscape -f "$line" -z --verb EditSelectAll --verb org.inkscape.color.desaturate.noprefs --verb FileSave --verb FileQuit
done < "convert_listtika"

echo "> Conversion complete, deleting SVG file cache ..."
#rm convert_listtika embedded_colorstika


