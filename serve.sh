#!/usr/bin/env bash

set -e

./build.sh --watch --no-jekyll

#crt="localhost.pem"
#key="localhost-key.pem"
#
#if [[ ! -f "$crt" || ! -f "$key" ]]; then
#	if command -v mkcert > /dev/null; then
#		mkcert -install
#		mkcert -cert-file "$crt" -key-file "$key" localhost 127.0.0.1 "::1" 0.0.0.0 192.168.1.100
#	fi
#fi
#
#if [[ -f "$crt" && -f "$key" ]]; then
#	# Can't serve live reload script over https
#	# https://github.com/jekyll/jekyll/issues/9495
#	bundler exec jekyll serve --ssl-cert "$crt" --ssl-key "$key" "$@"
#else
	bundler exec jekyll serve --livereload "$@"
#fi
