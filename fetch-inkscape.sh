#!/usr/bin/env bash

set -e

# Install Inkscape
echo "Downloading Inkscape..."
if [[ -f inkscape-version ]]; then
	cached_inkscape_version="$(<inkscape-version)"
fi
inkscape_url="$(curl -sLI 'https://inkscape.org/release/' -o /dev/null -w '%{url_effective}')"
inkscape_version="$inkscape_url"
inkscape_version="${inkscape_version%/}"
inkscape_version="${inkscape_version##*/}"
if [[ $inkscape_version != "$cached_inkscape_version" ]]; then
	inkscape_url="${inkscape_url}gnulinux/appimage/dl/"
	inkscape_appimage_url="https://inkscape.org$(curl -sL "$inkscape_url" | perl -nE 'm{<meta.*\bcontent=".*\burl=([/\w\.\-~]+)".*/>} && print $1')"
	curl -sL "$inkscape_appimage_url" -o inkscape
	echo Done
	printf "%s" "$inkscape_version" > inkscape-version
else
	echo "Found: $(realpath inkscape)"
fi
chmod +x inkscape
