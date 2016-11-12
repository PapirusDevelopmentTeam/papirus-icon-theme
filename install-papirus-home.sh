#!/bin/bash
set -e
echo "Papirus icon theme for GTK"
requirements=(wget 7z)
for program in "${requirements[@]}"; do
  if ! program_loc="$(type -p "$program")" || [ -z "$program_loc" ]; then
    echo "Program $program not found. Please install it and rerun the script"
    exit 1
  fi
done

echo "Deleting old Papirus icon theme ..."
rm -rf ~/.icons/{Papirus-GTK,Papirus-Dark-GTK}
echo "Downloading new version from GitHub ..."
wget -c https://github.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/archive/master.zip -O /tmp/papirus-icon-theme-gtk.zip
echo "Unpacking archive ..."
7z x /tmp/papirus-icon-theme-gtk.zip -o/tmp/
echo "Copying into ~/.icons"
mkdir -p ~/.icons
cp -R /tmp/papirus-icon-theme-gtk-master/{Papirus-GTK,Papirus-Dark-GTK} ~/.icons/
echo "Deleting cache ..."
rm /tmp/papirus-icon-theme-gtk.zip
rm -rf /tmp/papirus-icon-theme-gtk-master
echo "Done!"
