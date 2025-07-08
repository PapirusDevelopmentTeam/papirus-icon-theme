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

_rm_icon_theme() {
  test -d "$1" || return 0

  echo "Removing '$1'..." >&2

  if [ -w "$1" ]; then
     rm -rf "$1"
  else
    if command -v sudo >/dev/null; then
      sudo rm -rf "$1"
    elif command -v doas >/dev/null; then
      doas rm -rf "$1"
    else
      echo "Failed to remove '$1'. Please run the script with root permission." >&2
    fi
  fi
}

_yes_no() {
  printf '%s [Y/n]: ' "$*"
  read -r yes_no </dev/tty  # don't read from stdin

  case "$yes_no" in
    [Yy]|'') return 0 ;;
    [Nn]|*)  return 1 ;;
  esac
}

echo "=> Removing $gh_desc ..."
for d in "$HOME/.icons" "$HOME/.local/share/icons" "/usr/local/share/icons" "/usr/share/icons"; do
  for i in ePapirus ePapirus-Dark Papirus Papirus-Adapta Papirus-Adapta-Nokto Papirus-Dark Papirus-Light; do
    [ -d "$d/$i" ] || continue
    if _yes_no "Do you want to remove '$i' from '$d'"; then
      _rm_icon_theme "$d/$i"
    fi
  done
done

echo "=> Done!"
