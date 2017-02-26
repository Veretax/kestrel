#!/usr/bin/env bash

# This file sets up modules for Apache 2.5 and PHP

# install apache 2.5 and php 5.5
if [ $APACHE_INSTALL = true ]; then
	echo "************** Start Apache2 Install **************"
	sudo apt-get install -y apache2
fi

if [ $PHP_INSTALL = true ]; then
	echo "************** Start PHP5 Setup **************"
	sudo apt-get install -y php5

	echo "************** Beginning Setup of Modules for PHP **************"

	# install and enable mcrypt
	sudo apt-get install -y php5-mcrypt
	sudo php5enmod mcrypt

	# install and enable libapache2-mod-php5
	if [ $APACHE_INSTALL = true ]; then
		echo "************** Install and configure libapache2-mod-php5 ***************"
		sudo apt-get install -y libapache2-mod-php5
		sudo php5enmod libapache2-mod-php5
	fi

	# install and enable curl and curl for php5
	echo "************** Install and enable php5 libraries ***************"
	sudo apt-get install -y curl libcurl3 libcurl3-dev php5-curl
	
	echo "************** Enable curl, libcurl3, libcurl3-dev php5-curl **************"
	sudo php5enmod curl
	sudo php5enmod libcurl3
	sudo php5enmod libcurl3-dev
	sudo php5enmod php5-curl

	# install and enable php5 intl for human language and character encoding support
	echo "************** Install and setup PHP5 International language and character encoding support ***************"
	sudo apt-get install -y php5-intl
	sudo php5enmod php5-intl

	# install and enable mysqlnd mysql native driver
	#sudo apt-get install -y mysqlnd

	# install and enable tidy
	echo "************** Setup tidy and xsl modules ***************"
	sudo apt-get install -y tidy

	# install and enable php5-xsl
	sudo apt-get install -y php5-xsl
fi

# 