#!/bin/sh

set -eo

cd $GITHUB_WORKSPACE

npm install

npx stylelint **/*.scss --allow-empty-input
