#!/usr/bin/env bash

if ! command -v svgo >/dev/null
then
    echo "Please install svgo: npm install svgo"
    exit 1
fi
# regarding convertStyleToAttrs, see: https://github.com/svg/svgo/issues/489
# regarding convertPathData, see: https://github.com/svg/svgo/issues/490
ARGS="--pretty --disable=convertStyleToAttrs --disable=convertPathData"

function generatePng {
    inkscape -z -D $1 --export-png=$2 --export-width=200 --export-background=transparent > /dev/null
}

# args: pngA pngB final.svg temp.svg
function evaluateOptimization {
#     that regex is to just take A from "A (B)"
    res=`compare -metric MAE $1 $2 /dev/null 2>&1 | sed "s/^\\([0-9]*\\).*/\\1/"` #-fuzz 5
    if [ "$res" -gt 100 ]; then
        echo "huuuuge difference of $res in $3"
    else
        mv $4 $3
    fi
}

find . -name "*.svg" -size 4k -print0 | while IFS= read -r -d '' file
do
    echo "doing... $file"
    generatePng "$file" /tmp/A.png
    svgo -i "$file" -o "$file".tmp.svg $ARGS
    generatePng "$file".tmp.svg /tmp/B.png
    evaluateOptimization /tmp/A.png /tmp/B.png "$file" "$file".tmp.svg
done

find . -name "*.svgz" -print0 | while IFS= read -r -d '' file
do
    echo "z-doing... $file"
    generatePng "$file" /tmp/A.png
    gunzip "$file" -S .svgz -c | svgo -i - $ARGS | gzip -c > "$file".tmp.svgz
    generatePng "$file".tmp.svgz /tmp/B.png
    evaluateOptimization /tmp/A.png /tmp/B.png "$file" "$file".tmp.svgz
done
