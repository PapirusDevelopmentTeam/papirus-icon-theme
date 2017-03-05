#!/bin/sh

set -e

gh_repo="papirus-icon-theme"
gh_desc="Papirus icon theme"

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
sudo rm -rf /usr/share/icons/ePapirus
sudo rm -rf /usr/share/icons/Papirus
sudo rm -rf /usr/share/icons/Papirus-Dark
sudo rm -rf /usr/share/icons/Papirus-Light
rm -rf ~/.icons/ePapirus
rm -rf ~/.icons/Papirus
rm -rf ~/.icons/Papirus-Dark
rm -rf ~/.icons/Papirus-Light
rm -rf ~/.local/share/icons/ePapirus
rm -rf ~/.local/share/icons/Papirus
rm -rf ~/.local/share/icons/Papirus-Dark
rm -rf ~/.local/share/icons/Papirus-Light
echo "=> Done!"
