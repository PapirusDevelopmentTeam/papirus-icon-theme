#!/bin/sh

set -e

gh_repo="papirus-icon-theme"
gh_desc="Papirus icon theme KDE"

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
wget -O "/tmp/$gh_repo.tar.gz" \
  https://github.com/PapirusDevelopmentTeam/$gh_repo/archive/master.tar.gz

echo "=> Unpacking archive ..."
tar -xzf "/tmp/$gh_repo.tar.gz" -C "$temp_dir"

echo "=> Deleting old $gh_desc ..."
rm -rf ~/.local/share/icons/ePapirus
rm -rf ~/.local/share/icons/Papirus
rm -rf ~/.local/share/icons/Papirus-Adapta
rm -rf ~/.local/share/icons/Papirus-Dark
rm -rf ~/.local/share/icons/Papirus-Light

echo "=> Installing ..."
mkdir -p ~/.local/share/icons
cp -R \
  "$temp_dir/$gh_repo-master/ePapirus" \
  "$temp_dir/$gh_repo-master/Papirus" \
  "$temp_dir/$gh_repo-master/Papirus-Adapta" \
  "$temp_dir/$gh_repo-master/Papirus-Dark" \
  "$temp_dir/$gh_repo-master/Papirus-Light" ~/.local/share/icons/

echo "=> Clearing cache ..."
rm -f ~/.cache/icon-cache.kcache
rm -rf "/tmp/$gh_repo.tar.gz" "$temp_dir"

echo "=> Done!"
