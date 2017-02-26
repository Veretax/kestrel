#!/usr/bin/env bash

# install git
if [ $SETUP_GIT = true ]; then
	echo "*************** Installing git ***************"
	sudo apt-get -y install git
fi

if [ $SETUP_COMPOSER = true ]; then
# install Composer
	echo "*************** Install Composer via curl **************"
	curl -s https://getcomposer.org/installer | php
	mv composer.phar /usr/local/bin/composer
fi