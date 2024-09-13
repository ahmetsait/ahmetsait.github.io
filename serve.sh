#!/usr/bin/env bash

set -e

./build.sh --watch --no-jekyll
bundle exec jekyll serve --livereload "$@"
