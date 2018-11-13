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

_cleanup() {
  echo "=> Clearing cache ..."
  rm -rf "$temp_file" "$temp_dir"

  echo "=> Done!"
}

trap _cleanup EXIT HUP INT TERM

temp_file="$(mktemp -u)"
temp_dir="$(mktemp -d)"

echo "=> Getting the latest version from GitHub ..."
wget -O "$temp_file" \
  "https://github.com/PapirusDevelopmentTeam/$gh_repo/archive/HiDPI.tar.gz"

echo "=> Unpacking archive ..."
tar -xzf "$temp_file" -C "$temp_dir"

for icons_dir in \
  "/usr/share/icons" \
  "/usr/local/share/icons" \
  "$HOME/.icons" \
  "$HOME/.local/share/icons"
do
  [ -d "$icons_dir/Papirus" ] || continue

  echo "=> Deleting old $gh_desc ..."
  sudo rm -rf \
    "$icons_dir/Papirus.HiDPI" \
    "$icons_dir/Papirus-Dark.HiDPI" \
    "$icons_dir/Papirus-Light.HiDPI" \
    "$icons_dir/ePapirus.HiDPI" \
    "$icons_dir/Papirus-Adapta.HiDPI" \
    "$icons_dir/Papirus-Adapta-Nokto.HiDPI"

  echo "=> Installing ..."
  sudo cp -R \
    "$temp_dir/$gh_repo-HiDPI/Papirus.HiDPI" \
    "$temp_dir/$gh_repo-HiDPI/Papirus-Dark.HiDPI" \
    "$icons_dir"

  exit 0
done

echo "Error: Papirus icon theme cannot be found."
exit 1
