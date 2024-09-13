#!/usr/bin/env bash

set -e

./build.sh -J
bundle exec jekyll serve --livereload "$@"
