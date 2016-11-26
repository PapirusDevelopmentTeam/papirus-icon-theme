#!/bin/sh

set -e

gh_repo="papirus-icon-theme-gtk"
gh_desc="Papirus icon theme for GTK"

cat <<- EOF



      ppppp                         ii
      pp   pp     aaaaa   ppppp          rr  rrr   uu   uu     sssss
      ppppp     aa   aa   pp   pp   ii   rrrr      uu   uu   ssss
      pp        aa   aa   pp   pp   ii   rr        uu   uu      ssss
      pp          aaaaa   ppppp     ii   rr          uuuuu   sssss
                          pp
                          pp


  $gh_desc
  https://github.com/PapirusDevelopmentTeam/$gh_repo


EOF

echo "=> Removing $gh_desc ..."
sudo rm -rf /usr/share/icons/Papirus-GTK /usr/share/icons/Papirus-Dark-GTK
rm -rf ~/.icons/Papirus-GTK ~/.icons/Papirus-Dark-GTK
echo "=> Done!"
