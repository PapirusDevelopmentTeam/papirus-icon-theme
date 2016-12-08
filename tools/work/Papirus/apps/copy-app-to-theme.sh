#!/bin/bash
export f=`ls *16.svg | grep -o '^[^16]*'`.svg

rename 's/48.svg/.svg/' *48.svg
cp $f ../../../../Papirus/48x48/apps/
rename 's/32.svg/.svg/' *32.svg
cp $f ../../../../Papirus/32x32/apps/
rename 's/24.svg/.svg/' *24.svg
cp $f ../../../../Papirus/24x24/apps/
rename 's/22.svg/.svg/' *22.svg
cp $f ../../../../Papirus/22x22/apps/
rename 's/16.svg/.svg/' *16.svg
cp $f ../../../../Papirus/16x16/apps/
