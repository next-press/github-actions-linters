#!/bin/sh

set -eo

cd "$GITHUB_WORKSPACE"

# Use the name node_modules as it is usually already excluded
# on the phpcs.xml file.
# echo 'Create sub-folder, to avoid conflicts.'
# mkdir node_modules
# cd node_modules

if [ ! -f composer.json ]; then
    echo 'Setting up a Composer file'
    composer init --stability dev --no-interaction
fi

echo 'Installing Composer packages'
composer install --no-scripts

phpcs_package_exist() {
    composer show | grep squizlabs/php_codesniffer >/dev/null
}

if phpcs_package_exist; then
    echo 'PHP_CodeSniffer is installed'
else
    echo 'PHP_CodeSniffer is not installed'
    echo 'Installing PHP_CodeSniffer and WordPress CS'
    composer require dealerdirect/phpcodesniffer-composer-installer:0.5.0 wp-coding-standards/wpcs
fi

echo 'Installing NextPress Coding Standards'
composer require nextpress/nextpresscs --no-scripts

echo 'Installing Coding Standards'
composer run-script install-codestandards

STANDARD=' --standard=WordPress --ignore=*/vendor/* --extensions=php'
if [ -f .phpcs.xml ] || [ -f phpcs.xml ] || [ -f .phpcs.xml.dist ] || [ -f phpcs.xml.dist ]
then
	STANDARD=''
fi

echo 'Linting PHP files'
./vendor/bin/phpcs $STANDARD -s -p -n ../.
