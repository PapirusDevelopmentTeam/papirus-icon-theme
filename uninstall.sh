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
for i in ePapirus ePapirus-Dark Papirus Papirus-Adapta Papirus-Adapta-Nokto Papirus-Dark Papirus-Light; do
  rm -rf "$HOME/.icons/$i"
  rm -rf "$HOME/.local/share/icons/$i"
  sudo rm -rf "/usr/local/share/icons/$i"
  sudo rm -rf "/usr/share/icons/$i"
done

echo "=> Done!"
