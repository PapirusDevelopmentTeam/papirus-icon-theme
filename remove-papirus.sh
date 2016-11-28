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
sudo rm -rf /usr/share/icons/Papirus /usr/share/icons/Papirus-Dark
rm -rf ~/.icons/Papirus ~/.icons/Papirus-Dark
rm -rf ~/.local/share/icons/Papirus ~/.local/share/icons/Papirus-Dark
sudo rm -rf /usr/share/icons/Papiru*  # temporary
sudo rm -rf /usr/share/icons/papiru*  # temporary
rm -rf ~/.icons/Papiru*  # temporary
rm -rf ~/.local/share/icons/Papiru*  # temporary
echo "=> Done!"
