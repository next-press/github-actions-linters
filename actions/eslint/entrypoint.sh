#!/bin/sh

set -eo

cd "$GITHUB_WORKSPACE"

if [ ! -f package.json ]; then
	echo 'Creating package.json'
    npm init -y
fi

npm install

if [ "$(npm list eslint | grep empty)" ]; then
	echo 'Installing ESLint'
    npm install eslint
fi

if [ "$(npm list @wordpress/eslint-plugin | grep empty)" ]; then
	echo 'Installing WordPress Coding Standard'
    npm install @wordpress/eslint-plugin
fi

if [ ! -f .eslintrc ] && [ ! -f .eslintrc.json ] && [ ! -f .eslintrc.yaml ] && [ ! -f .eslintrc.yml ] && [ ! -f .eslintrc.js ]
then
	echo 'Creating ESLint config file'
	cat << ESLINT > ./.eslintrc.json
{
  "extends": [
    "plugin:@wordpress/eslint-plugin/recommended"
  ],
  "root": true,
  "env": {
    "browser": true,
    "node": true,
    "jquery": true
  },
  "globals": {
    "wp": true,
    "wpu": true
  }
}
ESLINT
fi

echo 'Running ESLint'
npx eslint **/*.js
