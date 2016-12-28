#!/usr/bin/env bash
set -e

make
git checkout gh-pages
git pull origin gh-pages
git add -f index.html
git commit --allow-empty -m 'publish'
git checkout master
