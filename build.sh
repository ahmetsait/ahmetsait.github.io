#!/usr/bin/env sh

bundle exec sass scss:css

bundle exec jekyll build "$@"
