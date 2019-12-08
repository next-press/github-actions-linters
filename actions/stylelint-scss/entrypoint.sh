#!/bin/sh

set -eo

npm install

npx stylelint **/*.scss --allow-empty-input
