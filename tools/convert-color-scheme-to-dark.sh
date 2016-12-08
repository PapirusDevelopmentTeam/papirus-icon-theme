#!/bin/bash
# This script change Papirus colors to Papirus Dark
# USAGE:
#./colors-dark.svg
echo "Change colors for Papirus Dark"
echo "Press <CTRL-C> to abort (wait 5 seconds) ..."
sleep 5
sed -i 's|{ color:#5c616c; }|{ color:#d3dae3; }|g' *.svg
sed -i 's|id="papirus"|id="papirus-dark"|g' *.svg
