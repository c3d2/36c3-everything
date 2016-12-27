#!/bin/bash -e

make
git co -b gh-pages
git rm -f .gitignore Makefile index.xsl publish.sh
git add -f index.html
git commit -m 'publish'
git co master
