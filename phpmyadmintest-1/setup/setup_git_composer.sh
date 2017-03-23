#!/usr/bin/env bash

# install git
if [ $SETUP_GIT = true ]; then
	echo "*************** Installing git ***************"  >> /vagrant/vm_build.log 2>&1
	sudo apt-get -y install git  >> /vagrant/vm_build.log 2>&1
fi

if [ $SETUP_COMPOSER = true ]; then
# install Composer
	echo "*************** Install Composer via curl **************" >> /vagrant/vm_build.log 2>&1
	curl -s https://getcomposer.org/installer | php >> /vagrant/vm_build.log 2>&1
	mv composer.phar /usr/local/bin/composer >> /vagrant/vm_build.log 2>&1
fi
