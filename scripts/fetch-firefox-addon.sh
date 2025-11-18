#!/usr/bin/env bash
# file: fetch-addon.sh

# Exit on any error and treat unset variables as errors
set -eu

# ------------------------------------------------------------------
# Helper: print usage information
# ------------------------------------------------------------------
usage() {
    echo "Usage: $0 <Addon URL>"
    echo "Uses the given URL to a FireFox addon to determine the addon id"
    echo "Please use a direct link to the .xpi file (from \"See all versions\")"
    exit 1
}

# ------------------------------------------------------------------
# Validate arguments
# ------------------------------------------------------------------
if [[ $# -ne 1 ]]; then
    echo "Error: exactly one argument expected."
    usage
fi

url=$1

# Optional sanity check – ensure it looks like a URL
if [[ ! "$url" =~ ^https?:// ]]; then
    echo "Warning: the argument does not start with http:// or https://"
fi

# ------------------------------------------------------------------
# Do the work – here we just curl the URL
# ------------------------------------------------------------------
# -s   silent mode (no progress meter)
# -L   follow redirects
# -f   fail on HTTP errors (non‑2xx/3xx)
download_url=$(
  echo "$url" \
    | sed -E 's|https://addons.mozilla.org/firefox/downloads/file/[0-9]+/([^/]+)-[^/]+\.xpi|\1|' \
    | tr '_' '-' \
    | awk '{print "https://addons.mozilla.org/firefox/downloads/latest/" $1 "/latest.xpi"}'
)

curl -sLfO "$download_url"

# -------------------------------------------------------------------
# Unzip extension and get its id
# -------------------------------------------------------------------
unzip -q *.xpi -d my-extension
cat ./my-extension/manifest.json | jq -r '.browser_specific_settings.gecko.id'

# -------------------------------------------------------------------
# Clean Up
# -------------------------------------------------------------------
rm -rf my-extension
rm -f latest.xpi
