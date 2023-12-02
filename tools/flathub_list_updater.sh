#!/usr/bin/env bash
# This script updates list of Flathub apps in specified GitHub issue

set -euo pipefail

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
API_ENDPOINT="https://api.github.com/repos/PapirusDevelopmentTeam/papirus-icon-theme/issues/2007"

api_response="$(mktemp -u --suffix=.json)"
unchecked_apps_list="$(mktemp -u)"
completed_apps_list="$(mktemp -u)"
missing_apps_list="$(mktemp -u)"
new_apps_list="$(mktemp -u)"

_cleanup() {
	rm -f \
		"$api_response" \
		"$unchecked_apps_list" \
		"$completed_apps_list" \
		"$missing_apps_list" \
		"$new_apps_list"
}

trap _cleanup EXIT HUP INT TERM

_api_request() {
	# using: _api_request API_ENDPOINT file.json
	local api_endpoint="${1?API endpoint is not set}"; shift

	curl \
		--silent \
		--location \
		--header "Authorization: token ${GITHUB_TOKEN?is not set}" \
		--header 'Accept: application/vnd.github+json' \
		--header 'X-GitHub-Api-Version: 2022-11-28' \
		--output "${1?Output file is not set}" \
		"$api_endpoint"
}

_api_post() {
	# usage: _api_post api_endpoint file.json [file2.json ...]
	local api_endpoint="${1?API endpoint is not set}"; shift

	if [ $# -eq 0 ]; then
		echo "_api_post: nothing to post" >&2
		exit 1
	fi

	jq --compact-output --raw-input --slurp '. as $body | {$body}' "$@" |
		curl \
			--silent \
			--output /dev/null \
			--header "Authorization: token ${GITHUB_TOKEN?is not set}" \
			--header 'Accept: application/vnd.github+json' \
			--header 'Content-Type: application/json' \
			--header 'X-GitHub-Api-Version: 2022-11-28' \
			--data @- \
			--request POST "$api_endpoint"
}

# Get an issue
_api_request "$API_ENDPOINT" "$api_response"

# Fall if API response is empty
if [ ! -s "$api_response" ]; then
	echo "Fatal: API response is empty." >&2
	exit 1
fi

# Split the markdown list in the issue to completed and uncompleted tasks
jq -r '.body' "$api_response" | tee \
	>(sed -n '/\[x\][ ]/p' > "$completed_apps_list") \
	>(sed -n '/\[ \][ ]/p' > "$unchecked_apps_list") \
	>/dev/null

env MARKDOWN=1 bash "$SCRIPT_DIR/missing_flathub_apps.sh" > "$missing_apps_list"

# Create a list of new Flatpak packages
comm -13 <(sort "$unchecked_apps_list") <(sort "$missing_apps_list") |
	sed 's/\[ \][ ]//' > "$new_apps_list"

if [ -s "$new_apps_list" ]; then
	echo "Uptading issue #${API_ENDPOINT##*/} ..." >&2
	_api_post "$API_ENDPOINT" "$missing_apps_list" "$completed_apps_list"

	echo "Add a comment with new apps list ..." >&2
	_api_post "$API_ENDPOINT/comments" "$new_apps_list"
fi
