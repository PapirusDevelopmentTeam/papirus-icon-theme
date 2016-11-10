#/bin/bash
echo "Papirus icon theme for GTK"
sleep 5
echo "Delete old Papirus icon theme ..."
sudo rm -rf /usr/share/icons/Papiru*
echo "Download new version from GitHub ..."
wget -c https://github.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/archive/master.zip -O /tmp/papirus-icon-theme-gtk.zip
echo "Unpack archive ..."
unzip -oq /tmp/papirus-icon-theme-gtk.zip -d /tmp/
echo "Installing ..."
sudo cp -R /tmp/papirus-icon-theme-gtk-master/Papiru* /usr/share/icons/
sudo chmod -R 755 /usr/share/icons/Papiru*
echo "Delete cache ..."
sudo rm -rf /tmp/papiru*
rm install-papirus.sh
echo "Done!"
