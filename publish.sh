#!/usr/bin/env bash
set -x -e

make clean
make
git branch -D gh-pages
git checkout -b gh-pages origin/master
git add -f ?.html
git commit -m 'publish'
git push -f
git checkout master
