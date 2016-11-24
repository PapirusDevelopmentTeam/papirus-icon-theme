#!/usr/bin/env bash
echo "Papirus icon theme for GTK"
! which 7za > /dev/null 2>&1 && { echo "Please install p7zip-full"; exit 1; }
echo "Download new version from GitHub ..."
wget -c https://github.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/archive/master.zip -O /tmp/papirus-icon-theme-gtk.zip
echo "Unpack archive ..."
7za x /tmp/papirus-icon-theme-gtk.zip -o/tmp/ > /dev/null
echo "Delete old Papirus icon theme ..."
sudo rm -rf /usr/share/icons/{Papirus-GTK,Papirus-Dark-GTK}
echo "Installing ..."
sudo cp -R /tmp/papirus-icon-theme-gtk-master/{Papirus-GTK,Papirus-Dark-GTK} /usr/share/icons/
sudo chmod -R 755 /usr/share/icons/{Papirus-GTK,Papirus-Dark-GTK}
echo "Delete cache ..."
rm -rf /tmp/papiru*
echo "Done!"
