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


temp_dir=$(mktemp -d)

if [ -d "/usr/local/share/icons/hicolor" ]; then
  # is a BSD system
  data_dir="/usr/local"
else
  data_dir="/usr"
fi

echo "=> Getting the latest version from GitHub ..."
wget -O "/tmp/$gh_repo.tar.gz" \
  https://github.com/PapirusDevelopmentTeam/$gh_repo/archive/master.tar.gz

echo "=> Unpacking archive ..."
tar -xzf "/tmp/$gh_repo.tar.gz" -C "$temp_dir"

echo "=> Deleting old $gh_desc ..."
sudo rm -rf "$data_dir/share/icons/ePapirus"
sudo rm -rf "$data_dir/share/icons/Papirus"
sudo rm -rf "$data_dir/share/icons/Papirus-Adapta"
sudo rm -rf "$data_dir/share/icons/Papirus-Adapta-Nokto"
sudo rm -rf "$data_dir/share/icons/Papirus-Dark"
sudo rm -rf "$data_dir/share/icons/Papirus-Light"

echo "=> Installing ..."
sudo cp -R \
  "$temp_dir/$gh_repo-master/ePapirus" \
  "$temp_dir/$gh_repo-master/Papirus" \
  "$temp_dir/$gh_repo-master/Papirus-Adapta" \
  "$temp_dir/$gh_repo-master/Papirus-Adapta-Nokto" \
  "$temp_dir/$gh_repo-master/Papirus-Dark" \
  "$temp_dir/$gh_repo-master/Papirus-Light" $data_dir/share/icons/

# Try to restore the color of folders from a config
if which papirus-folders > /dev/null 2>&1; then
  sudo papirus-folders -R || true
fi

sudo gtk-update-icon-cache -q "$data_dir/share/icons/ePapirus" || true
sudo gtk-update-icon-cache -q "$data_dir/share/icons/Papirus" || true
sudo gtk-update-icon-cache -q "$data_dir/share/icons/Papirus-Adapta" || true
sudo gtk-update-icon-cache -q "$data_dir/share/icons/Papirus-Adapta-Nokto" || true
sudo gtk-update-icon-cache -q "$data_dir/share/icons/Papirus-Dark" || true
sudo gtk-update-icon-cache -q "$data_dir/share/icons/Papirus-Light" || true

echo "=> Clearing cache ..."
rm -rf "/tmp/$gh_repo.tar.gz" "$temp_dir"

echo "=> Done!"
