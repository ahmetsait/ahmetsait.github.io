#!/usr/bin/env bash

set -e

# Install ImageMagick
echo "Downloading ImageMagick..."
status="$(curl -sL --etag-compare magick-etag --etag-save magick-etag 'https://imagemagick.org/archive/binaries/magick' -o magick -w "%{http_code}")"
if [[ status -eq 304 ]]; then
	echo "Found: $(realpath magick)"
else
	echo Done
fi
chmod +x magick
