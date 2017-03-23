#!/usr/bin/env bash

if [ $MYSQL_SETUP = true ] ; then

	PASSWORD = $1

	# install mysql and give password to installer
	echo "************** Preparing to setup mysql and phpmyadmin ***************" >> /vagrant/vm_build.log 2>&1

	echo "************** Begin install of mysql **************" >> /vagrant/vm_build.log 2>&1

	
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD" >> /vagrant/vm_build.log 2>&1

	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD" >> /vagrant/vm_build.log 2>&1

	sudo apt-get -y install mysql-server >> /vagrant/vm_build.log 2>&1 >> /vagrant/vm_build.log 2>&1

	
	echo "************** install php5 support for mysql **************" >> /vagrant/vm_build.log 2>&1

	sudo apt-get install php5-mysql >> /vagrant/vm_build.log 2>&1


	echo "************** Securing mysql server **************" >> /vagrant/vm_build.log 2>&1

	# install phpmyadmin and give password(s) to installer
	# for simplicity I'm using the same password for mysql and phpmyadmin
	


	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true" >> /vagrant/vm_build.log 2>&1
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD" >> /vagrant/vm_build.log 2>&1
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD" >> /vagrant/vm_build.log 2>&1
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD" >> /vagrant/vm_build.log 2>&1
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" >> /vagrant/vm_build.log 2>&1
	
	echo "************** setting up phpymyadmin *************" >> /vagrant/vm_build.log 2>&1
	sudo apt-get -y install phpmyadmin >> /vagrant/vm_build.log 2>&1

fi