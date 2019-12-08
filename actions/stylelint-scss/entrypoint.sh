#!/bin/sh

set -eo

cd "$GITHUB_WORKSPACE"

if [ ! -f package.json ]; then
	echo 'Creating package.json'
    npm init -y
fi

npm install

if [ "$(npm list stylelint | grep empty)" ]; then
	echo 'Installing stylelint'
    npm install stylelint
fi

if [ "$(npm list stylelint-config-wordpress | grep empty)" ]; then
	echo 'Installing WordPress Coding Standard'
    npm install stylelint-config-wordpress
fi

if [ ! -f .stylelintrc ] && [ ! -f .stylelintrc.json ] && [ ! -f .stylelintrc.yaml ] && [ ! -f .stylelintrc.yml ] && [ ! -f .stylelintrc.js ]
then
	echo 'Creating stylelint config file'
	cat << STYLELINT > ./.stylelintrc.json
{
  "extends": "stylelint-config-wordpress/scss"
}
STYLELINT
fi

echo 'Running stylelint'
npx stylelint **/*.scss --allow-empty-input
