#!/bin/sh

set -e

cat <<- 'EOF'



      ppppp                         ii
      pp   pp     aaaaa   ppppp          rr  rrr   uu   uu     sssss
      ppppp     aa   aa   pp   pp   ii   rrrr      uu   uu   ssss
      pp        aa   aa   pp   pp   ii   rr        uu   uu      ssss
      pp          aaaaa   ppppp     ii   rr          uuuuu   sssss
                          pp
                          pp


  Papirus icon theme for GTK
  https://github.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk


EOF

echo "=> Removing Papirus icon theme for GTK ..."
sudo rm -rf /usr/share/icons/Papirus-GTK /usr/share/icons/Papirus-Dark-GTK
rm -rf ~/.icons/Papirus-GTK ~/.icons/Papirus-Dark-GTK
echo "=> Done!"
