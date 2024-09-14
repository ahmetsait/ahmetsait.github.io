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
	# https://gitlab.com/inkscape/inkscape/-/issues/4716#note_1898150983
	if [[ $3 -nt $2 ]]; then
		SELF_CALL=xxx inkscape -C -y 0 -w $1 -h $1 -o "$2" "$3" 2>/dev/null
	fi
}

apple_touch_icon_inner_size=155
apple_touch_icon_size=180

sizes=(512 256 255 192 180 150 128 96 72 64 48 32 24 20 16)
sizes+=($apple_touch_icon_inner_size)
readarray -d '' -t sizes < <(for s in "${sizes[@]}"; do printf '%s\0' "$s"; done | sort -r -n -z)

for f in "$@"; do
	name="${f%.*}"
	pngs=()
	declare -A size2job
	declare -A job2png
	for i in "${sizes[@]}"; do
		png="$name-${i}.png"
		export_png "$i" "$png" "$f" &
		size2job["$i"]=$!
		job2png[$!]="$png"
	done
	for i in "${sizes[@]}"; do
		if (( i < 256 && i != apple_touch_icon_inner_size )); then
			j="${size2job["$i"]}"
			if wait "$j"; then
				pngs+=("${job2png["$j"]}")
			fi
		fi
	done
	ico="$name.ico"
	magick convert -background none "${pngs[@]}" "$ico"
	
	j="${size2job[$apple_touch_icon_inner_size]}"
	if [[ -n $j ]] && wait "$j"; then
		png="${job2png["$j"]}"
		touch_icon="$(dirname "$name")/apple-touch-icon.png"
		magick convert "$png" -define png:exclude-chunks=date,time -background white -gravity center -extent "${apple_touch_icon_size}x${apple_touch_icon_size}" "$touch_icon" &&
		rm "$png"
	fi
done

wait
