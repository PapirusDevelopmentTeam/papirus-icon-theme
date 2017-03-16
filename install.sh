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

temp_dir=$(mktemp -d)

echo "=> Getting the latest version from GitHub ..."
wget -O "/tmp/$gh_repo.tar.gz" \
  https://github.com/PapirusDevelopmentTeam/$gh_repo/archive/HiDPI.tar.gz
echo "=> Unpacking archive ..."
tar -xzf "/tmp/$gh_repo.tar.gz" -C "$temp_dir"

if [ -d /usr/share/icons/Papirus ]; then
  echo "=> Deleting old $gh_desc ..."
  sudo rm -rf "/usr/share/icons/ePapirus.HiDPI"
  sudo rm -rf "/usr/share/icons/Papirus.HiDPI"
  sudo rm -rf "/usr/share/icons/Papirus-Dark.HiDPI"
  sudo rm -rf "/usr/share/icons/Papirus-Light.HiDPI"
  echo "=> Installing ..."
  sudo cp --no-preserve=mode,ownership -r \
    "$temp_dir/$gh_repo-HiDPI/ePapirus.HiDPI" \
    "$temp_dir/$gh_repo-HiDPI/Papirus.HiDPI" \
    "$temp_dir/$gh_repo-HiDPI/Papirus-Dark.HiDPI" \
    "$temp_dir/$gh_repo-HiDPI/Papirus-Light.HiDPI" /usr/share/icons/
elif [ -d ~/.icons/Papirus ]; then
  echo "=> Deleting old $gh_desc ..."
  rm -rf "$HOME/.icons/ePapirus.HiDPI"
  rm -rf "$HOME/.icons/Papirus.HiDPI"
  rm -rf "$HOME/.icons/Papirus-Dark.HiDPI"
  rm -rf "$HOME/.icons/Papirus-Light.HiDPI"
  echo "=> Installing ..."
  cp --no-preserve=mode,ownership -r \
    "$temp_dir/$gh_repo-HiDPI/ePapirus.HiDPI" \
    "$temp_dir/$gh_repo-HiDPI/Papirus.HiDPI" \
    "$temp_dir/$gh_repo-HiDPI/Papirus-Dark.HiDPI" \
    "$temp_dir/$gh_repo-HiDPI/Papirus-Light.HiDPI" ~/.icons/
elif [ -d ~/.local/share/icons/Papirus ]; then
  echo "=> Deleting old $gh_desc ..."
  rm -rf "$HOME/.local/share/icons/ePapirus.HiDPI"
  rm -rf "$HOME/.local/share/icons/Papirus.HiDPI"
  rm -rf "$HOME/.local/share/icons/Papirus-Dark.HiDPI"
  rm -rf "$HOME/.local/share/icons/Papirus-Light.HiDPI"
  echo "=> Installing ..."
  cp --no-preserve=mode,ownership -r \
    "$temp_dir/$gh_repo-HiDPI/ePapirus.HiDPI" \
    "$temp_dir/$gh_repo-HiDPI/Papirus.HiDPI" \
    "$temp_dir/$gh_repo-HiDPI/Papirus-Dark.HiDPI" \
    "$temp_dir/$gh_repo-HiDPI/Papirus-Light.HiDPI" ~/.local/share/icons/
else
  echo "!! Papirus icon theme cannot be found."
fi

echo "=> Clearing cache ..."
rm -rf "/tmp/$gh_repo.tar.gz" "$temp_dir"
echo "=> Done!"
