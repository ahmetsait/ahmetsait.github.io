#!/usr/bin/env bash

inkscape_url="$(curl -sLI 'https://inkscape.org/release/' -o /dev/null -w '%{url_effective}')"
inkscape_version="$inkscape_url"
inkscape_version="${inkscape_version%/}"
inkscape_version="${inkscape_version##*/}"
printf "%s" "$inkscape_version"
