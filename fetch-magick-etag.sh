#!/usr/bin/env bash

curl -sLI 'https://imagemagick.org/archive/binaries/magick' | perl -nE 'm{^ETag:\s*(.+?(?=\r\n))}i && printf($1)'
