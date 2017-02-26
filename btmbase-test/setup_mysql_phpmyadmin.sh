#!/usr/bin/env bash

if [ $MYSQL_SETUP = true ] ; then

	PASSWORD = $1

	# install mysql and give password to installer
	echo "************** Preparing to setup mysql and phpmyadmin ***************"
	echo "************** Begin install of mysql **************"
	
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
	sudo apt-get -y install mysql-server
	
	echo "************** install php5 support for mysql **************"
	sudo apt-get install php5-mysql

	echo "************** Securing mysql server **************"
	# install phpmyadmin and give password(s) to installer
	# for simplicity I'm using the same password for mysql and phpmyadmin
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
	
	echo "************** setting up phpymyadmin *************"
	sudo apt-get -y install phpmyadmin

fi