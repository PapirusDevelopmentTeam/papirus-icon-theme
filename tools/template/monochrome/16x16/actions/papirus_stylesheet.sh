#!/bin/bash
# Papirus stylesheet
export SVGPAPIRUS=`ls | grep _p.svg`
# add classes
xmlstarlet ed --subnode "//*/*[contains(@style, '${colors[i]}') and not (@class)]" -t attr -n "class" -v "${colorNames[i]}" $SVGPAPIRUS > $SVGPAPIRUS.temp
sed -i 's|class=""/>|/>|g' $SVGPAPIRUS.temp
sed -i 's|class="">|>|g' $SVGPAPIRUS.temp
mv $SVGPAPIRUS.temp $SVGPAPIRUS
# remove colors
sed -i 's|"color:#5c616c;|"|g' $SVGPAPIRUS
sed -i 's|"color:#5294e2;|"|g' $SVGPAPIRUS
sed -i 's|"color:#d3dae3;|"|g' $SVGPAPIRUS
sed -i 's|color:#5c616c;"|"|g' $SVGPAPIRUS
sed -i 's|color:#5294e2;"|"|g' $SVGPAPIRUS
sed -i 's|color:#d3dae3;"|"|g' $SVGPAPIRUS
# replace fill
sed -i 's/fill:#5c616c/fill:currentColor/g' $SVGPAPIRUS
sed -i 's/fill:#5294e2/fill:currentColor/g' $SVGPAPIRUS
sed -i 's/fill:#d3dae3/fill:currentColor/g' $SVGPAPIRUS
