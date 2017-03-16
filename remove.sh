#!/bin/sh

set -e

gh_repo="papirus-icon-theme"
gh_desc="Papirus icon theme (workaround for HiDPI screens)"

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
sudo rm -rf /usr/share/icons/ePapirus.HiDPI
sudo rm -rf /usr/share/icons/Papirus.HiDPI
sudo rm -rf /usr/share/icons/Papirus-Dark.HiDPI
sudo rm -rf /usr/share/icons/Papirus-Light.HiDPI
rm -rf ~/.icons/ePapirus.HiDPI
rm -rf ~/.icons/Papirus.HiDPI
rm -rf ~/.icons/Papirus-Dark.HiDPI
rm -rf ~/.icons/Papirus-Light.HiDPI
rm -rf ~/.local/share/icons/ePapirus.HiDPI
rm -rf ~/.local/share/icons/Papirus.HiDPI
rm -rf ~/.local/share/icons/Papirus-Dark.HiDPI
rm -rf ~/.local/share/icons/Papirus-Light.HiDPI
echo "=> Done!"
