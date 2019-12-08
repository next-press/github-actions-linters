#!/bin/sh

set -eo

cd "$GITHUB_WORKSPACE"

if [ ! -f composer.json ]; then
	echo 'Setting up a Composer file'
    composer init
fi

echo 'Installing Composer packages'
composer install

phpcs_package_exist() {
    composer show | grep squizlabs/php_codesniffer >/dev/null
}

if phpcs_package_exist; then
    echo 'PHP_CodeSniffer is installed'
else
    echo 'PHP_CodeSniffer is not installed'
    echo 'Installing PHP_CodeSniffer and WordPress CS'
    composer require dealerdirect/phpcodesniffer-composer-installer wp-coding-standards/wpcs
fi

STANDARD=' --standard=WordPress --ignore=*/vendor/* --extensions=php'
if [ -f .phpcs.xml ] || [ -f phpcs.xml ] || [ -f .phpcs.xml.dist ] || [ -f phpcs.xml.dist ]
then
	STANDARD=''
fi

echo 'Linting PHP files'
./vendor/bin/phpcs $STANDARD -s -p -n .
