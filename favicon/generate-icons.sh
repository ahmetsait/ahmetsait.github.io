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

export_png() {
	inkscape -C -y 0 -w $1 -h $1 -o "$2" "$3" 2>/dev/null && magick identify "$2"
}

for f in "$@"; do
	name="${f%.*}"
	for i in 512 255 150; do
		png="$name-${i}.png"
		export_png "$i" "$png" "$f" &
	done
	pngs=()
	for i in 192 128 96 72 64 48 32 24 16; do
		png="$name-${i}.png"
		export_png "$i" "$png" "$f" &
		pngs+=("$png")
	done
	wait
	ico="$name.ico"
	magick convert -background none "${pngs[@]}" "$ico" && magick identify "$ico"
done

wait
