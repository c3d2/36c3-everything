#!/usr/bin/env bash
set -x

make
git branch -D gh-pages
git checkout -b gh-pages origin/master
git add -f index.html
git commit -m 'publish'
git push -f
