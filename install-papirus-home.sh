#!/bin/sh

set -e

cat <<- 'EOF'



      ppppp                         ii
      pp   pp     aaaaa   ppppp          rr  rrr   uu   uu     sssss
      ppppp     aa   aa   pp   pp   ii   rrrr      uu   uu   ssss
      pp        aa   aa   pp   pp   ii   rr        uu   uu      ssss
      pp          aaaaa   ppppp     ii   rr          uuuuu   sssss
                          pp
                          pp


  Papirus icon theme for GTK
  https://github.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk


EOF

temp_dir=$(mktemp -d)

echo "=> Getting the latest version from GitHub ..."
curl --progress-bar -Lfo /tmp/papirus-icon-theme-gtk.tar.gz \
  https://github.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/archive/master.tar.gz
echo "=> Unpacking archive ..."
tar -xzf /tmp/papirus-icon-theme-gtk.tar.gz -C "$temp_dir"
echo "=> Deleting old Papirus icon theme ..."
rm -rf ~/.icons/Papirus-GTK ~/.icons/Papirus-Dark-GTK
echo "=> Installing ..."
mkdir -p ~/.icons
cp --no-preserve=mode,ownership -r \
  "$temp_dir/papirus-icon-theme-gtk-master/Papirus-GTK" \
  "$temp_dir/papirus-icon-theme-gtk-master/Papirus-Dark-GTK" ~/.icons/
echo "=> Clearing cache ..."
rm -rf /tmp/papirus-icon-theme-gtk.tar.gz "$temp_dir"
echo "=> Done!"
