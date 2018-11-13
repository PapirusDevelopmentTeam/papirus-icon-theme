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
for icons_dir in \
  "/usr/share/icons" \
  "/usr/local/share/icons" \
  "$HOME/.icons" \
  "$HOME/.local/share/icons"
do
  sudo rm -rf "$icons_dir/ePapirus.HiDPI"
  sudo rm -rf "$icons_dir/Papirus.HiDPI"
  sudo rm -rf "$icons_dir/Papirus-Dark.HiDPI"
  sudo rm -rf "$icons_dir/Papirus-Light.HiDPI"
  sudo rm -rf "$icons_dir/Papirus-Adapta.HiDPI"
  sudo rm -rf "$icons_dir/Papirus-Adapta-Nokto.HiDPI"
done

echo "=> Done!"
