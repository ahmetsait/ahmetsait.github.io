#!/usr/bin/env bash

watch=0
no_jekyll=0

while [[ $# -gt 0 ]]; do
	case "$1" in
		-w|--watch)
			watch=1
			shift
			;;
		-J|--no-jekyll)
			no_jekyll=1
			shift
			;;
		*)
			break
			;;
	esac
done

set -e

echo "Generating images..."
./gen-icon.sh assets/opengraph-*.svg assets/twitter-*.svg &
asset_job=$!
./gen-icon.sh favicon/favicon.svg --sizes=512,256,255,192,180,150,128,96,72,64,48,32,24,20,16 --apple &
favicon_job=$!
wait -n "$asset_job"
wait -n "$favicon_job"
echo "Done"

echo "Compiling Sass..."
bundler exec sass --update scss:css
if [[ watch -ne 0 ]]; then
	bundler exec sass --update --watch scss:css &
fi
echo "Done"

if [[ no_jekyll -eq 0 ]]; then
	bundler exec jekyll build "$@"
fi
