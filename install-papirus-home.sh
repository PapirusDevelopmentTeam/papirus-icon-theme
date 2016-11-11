#/bin/bash
echo "Papirus icon theme for GTK"
sleep 5
echo "Delete old Papirus icon theme ..."
rm -rf ~/.icons/{Papirus-GTK,Papirus-Dark-GTK}
echo "Download new version from GitHub ..."
wget -c https://github.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/archive/master.zip -O /tmp/papirus-icon-theme-gtk.zip
echo "Unpack archive ..."
7z x /tmp/papirus-icon-theme-gtk.zip -o/tmp/
echo "Installing ..."
mkdir ~/.icons
cp -R /tmp/papirus-icon-theme-gtk-master/{Papirus-GTK,Papirus-Dark-GTK} ~/.icons/
echo "Delete cache ..."
rm -rf /tmp/papiru*
echo "Done!"
