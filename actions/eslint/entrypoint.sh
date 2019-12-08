#!/bin/sh

set -eo

cd $GITHUB_WORKSPACE

npm install

npx eslint **/*.js