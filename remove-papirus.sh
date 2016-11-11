#/bin/bash
echo "Remove Papirus icon theme for GTK"
sudo rm -rf /usr/share/icons/{Papirus-GTK,Papirus-Dark-GTK}
rm -rf ~/.icons/{Papirus-GTK,Papirus-Dark-GTK}
echo "Done!"
