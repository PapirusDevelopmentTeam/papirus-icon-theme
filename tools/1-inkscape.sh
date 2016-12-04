for file in *.svg; do inkscape -z -f $file --verb=FileSave $file; done
