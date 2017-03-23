#!/usr/bin/env bash

# This file sets up modules for Apache 2.5 and PHP

# install apache 2.5 and php 5.5
if [ $APACHE_INSTALL = true ]; then
	echo "************** Start Apache2 Install **************"  >> /vagrant/vm_build.log 2>&1
	sudo apt-get install -y apache2  >> /vagrant/vm_build.log 2>&1
fi

if [ $PHP_INSTALL = true ]; then
	echo "************** Start PHP5 Setup **************"  >> /vagrant/vm_build.log 2>&1
	sudo apt-get install -y php5 >> /vagrant/vm_build.log 2>&1

	echo "************** Beginning Setup of Modules for PHP **************" >> /vagrant/vm_build.log 2>&1

	# install and enable mcrypt
	sudo apt-get install -y php5-mcrypt >> /vagrant/vm_build.log 2>&1
	sudo php5enmod mcrypt >> /vagrant/vm_build.log 2>&1

	# install and enable libapache2-mod-php5
	if [ $APACHE_INSTALL = true ]; then
		echo "************** Install and configure libapache2-mod-php5 ***************" >> /vagrant/vm_build.log 2>&1
		sudo apt-get install -y libapache2-mod-php5 >> /vagrant/vm_build.log 2>&1
		sudo php5enmod libapache2-mod-php5 >> /vagrant/vm_build.log 2>&1
	fi

	# install and enable curl and curl for php5
	echo "************** Install and enable php5 libraries ***************" >> /vagrant/vm_build.log 2>&1
	sudo apt-get install -y curl libcurl3 libcurl3-dev php5-curl >> /vagrant/vm_build.log 2>&1
	
	echo "************** Enable curl, libcurl3, libcurl3-dev php5-curl **************" >> /vagrant/vm_build.log 2>&1
	sudo php5enmod curl >> /vagrant/vm_build.log 2>&1
	sudo php5enmod libcurl3 >> /vagrant/vm_build.log 2>&1
	sudo php5enmod libcurl3-dev >> /vagrant/vm_build.log 2>&1
	sudo php5enmod php5-curl >> /vagrant/vm_build.log 2>&1

	# install and enable php5 intl for human language and character encoding support
	echo "************** Install and setup PHP5 International language and character encoding support ***************" >> /vagrant/vm_build.log 2>&1
	sudo apt-get install -y php5-intl >> /vagrant/vm_build.log 2>&1
	sudo php5enmod php5-intl >> /vagrant/vm_build.log 2>&1

	# install and enable mysqlnd mysql native driver
	#sudo apt-get install -y mysqlnd

	# install and enable tidy
	echo "************** Setup tidy and xsl modules ***************" >> /vagrant/vm_build.log 2>&1
	sudo apt-get install -y tidy >> /vagrant/vm_build.log 2>&1

	# install and enable php5-xsl
	sudo apt-get install -y php5-xsl >> /vagrant/vm_build.log 2>&1
fi

# 