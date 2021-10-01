#!/usr/bin/env bash
# This script updates list of Flathub apps in specified GitHub issue

set -euo pipefail

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
API_ENDPOINT="https://api.github.com/repos/PapirusDevelopmentTeam/papirus-icon-theme/issues/2007"

unchecked_apps_list="$(mktemp -u)"
completed_apps_list="$(mktemp -u)"
missing_apps_list="$(mktemp -u)"

_cleanup() {
	rm -f "$unchecked_apps_list" "$completed_apps_list" "$missing_apps_list"
}

trap _cleanup EXIT HUP INT TERM

curl -s "$API_ENDPOINT" |
	jq -r '.body' | tee \
	>(sed -n '/\[x\][ ]/p' > "$completed_apps_list") \
	>(sed -n '/\[ \][ ]/p' > "$unchecked_apps_list") \
	>/dev/null

env MARKDOWN=1 bash "$SCRIPT_DIR/missing_flathub_apps.sh" > "$missing_apps_list"

if ! diff -w --brief "$unchecked_apps_list" "$missing_apps_list" >/dev/null; then
	echo "Uptading issue #${API_ENDPOINT##*/} ..." >&2
	jq --compact-output --raw-input --slurp '. as $body | {$body}' \
		"$missing_apps_list" "$completed_apps_list" |
		curl \
			--silent \
			--output /dev/null \
			--header "Authorization: token ${GITHUB_TOKEN?is not set}" \
			--header 'Content-Type: application/json' \
			--data @- \
			--request PATCH "$API_ENDPOINT"
fi
