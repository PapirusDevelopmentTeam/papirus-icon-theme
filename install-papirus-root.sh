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

temp_dir=$(mktemp -d)

echo "=> Getting the latest version from GitHub ..."
curl --progress-bar -Lfo "/tmp/$gh_repo.tar.gz" \
  https://github.com/PapirusDevelopmentTeam/$gh_repo/archive/master.tar.gz
echo "=> Unpacking archive ..."
tar -xzf "/tmp/$gh_repo.tar.gz" -C "$temp_dir"
echo "=> Deleting old $gh_desc ..."
sudo rm -rf /usr/share/icons/Papirus-GTK /usr/share/icons/Papirus-Dark-GTK
echo "=> Installing ..."
sudo cp --no-preserve=mode,ownership -r \
  "$temp_dir/$gh_repo-master/Papirus-GTK" \
  "$temp_dir/$gh_repo-master/Papirus-Dark-GTK" /usr/share/icons/
echo "=> Clearing cache ..."
rm -rf "/tmp/$gh_repo.tar.gz" "$temp_dir"
echo "=> Done!"
