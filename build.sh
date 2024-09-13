#!/usr/bin/env bash

no_jekyll=0

while [[ $# -gt 0 ]]; do
	case "$1" in
		-J)
			no_jekyll=1
			shift
			;;
		-*|--*)
			echo "Unknown option: $1" >&2
			exit 1
			;;
		*)
			echo "Unexpected argument: $1" >&2
			exit 1
			;;
	esac
done

set -e

./favicon/generate-icons.sh favicon/favicon.svg

if [[ no_jekyll -eq 0 ]]; then
	bundle exec jekyll build "$@"
fi
