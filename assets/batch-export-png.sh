#!/usr/bin/env bash 

command -v inkscape > /dev/null; inkscape=$?

if [[ $inkscape != 0 ]]; then
	echo $'Cannot find \'inkscape\' command. Make sure Inkscape is installed and reachable from the current working directory. See: https://inkscape.org' >&2
	exit 1
fi

command -v magick > /dev/null; magick=$?

if [[ $magick != 0 ]]; then
	echo $'Cannot find \'magick\' command. Make sure ImageMagick is installed and reachable from the current working directory. See: https://www.imagemagick.org' >&2
	exit 1
fi

for f in "$@"; do
	name="${f%.*}"
	for i in 512 500 384 370 310 256 200 192 180 150 144 128 100 96 72 70 64 48 36 32 16; do
		png="$name-${i}px.png"
		inkscape -C -y 0 -w $i -h $i -o "$png" "$f" 2>/dev/null && magick identify "$png"
	done
done
