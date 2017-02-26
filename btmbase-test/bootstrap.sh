#!/usr/bin/env bash


# Get Setup Variables
source /vagrant/install_vars.sh

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='12345678'
PROJECTFOLDER='btm-dev'

# create project folder
sudo mkdir "/var/www/html/${PROJECTFOLDER}"

# Setup Bash Alias and Profile
cp /vagrant/bash_aliases.txt ~/.bash_aliases
cp /vagrant/bash_rc.txt ~/.bashrc

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# Call Setup of Apache 2.5 and PHP 5.5

# echo "************** Beginning Setup of Apache 2.5 and PHP 5.5 **************"

SCRIPT_NAME=$0
SCRIPT_FULL_PATH=$(dirname "$0")
VAGRANT_PATH="/vagrant"

echo "script_name: $SCRIPT_NAME"
echo "full path: $SCRIPT_FULL_PATH"
echo "vagrant path: $VAGRANT_PATH"

# $APACHESETUPPATH="./apache_php_setup.sh"

# OUTPUT=$($APACHESETUPPATH)
# echo $OUTPUT

if [ $APACHE_INSTALL = true ] || [ $PHP_INSTALL = true ]; then
	source "/vagrant/apache_php_setup.sh"
fi

if [ $MYSQL_SETUP = true ]; then
	source "/vagrant/setup_mysql_phpmyadmin.sh" $PASSWORD
fi

if [ $SETUP_APACHE_VIRTUAL_HOSTS = true ]; then
	source "/vagrant/setup_virtual_hosts.sh"
fi

if [ $SETUP_GIT = true ]; then
	source "/vagrant/setup_git_composer.sh"
fi

# echo "************** Beginning Setup of MySQL and PHPMyAdmin **************"

# source "/vagrant/setup_mysql_phpmyadmin.sh" $PASSWORD
# (exec "/vagrant/setup_mysql_phpmyadmin.sh" $PASSWORD )

# /vagrant/setup_mysql_phpmyadmin.sh $PASSWORD

# echo "************** Beginning Setup of Virtual Hosts **************"

# (exec "/vagrant/setup_virtual_hosts.sh" )

# echo "************** Beginning Setup of git and composer **************"

# (exec "/vagrant/setup_git_composer.sh" )

# # install apache 2.5 and php 5.5
# sudo apt-get install -y apache2
# sudo apt-get install -y php5

# # install and enable mcrypt
# sudo apt-get install -y php5-mcrypt
# sudo php5enmod mcrypt

# # install and enable libapache2-mod-php5
# sudo apt-get install -y libapache2-mod-php5
# sudo php5enmod libapache2-mod-php5

# # install and enable curl and curl for php5
# sudo apt-get install -y curl libcurl3 libcurl3-dev php5-curl
# sudo php5enmod curl
# sudo php5enmod libcurl3
# sudo php5enmod libcurl3-dev
# sudo php5enmod php5-curl

# # install and enable php5 intl for human language and character encoding support
# sudo apt-get install -y php5-intl
# sudo php5enmod php5-intl

# # install and enable mysqlnd mysql native driver
# #sudo apt-get install -y mysqlnd

# # install and enable tidy
# sudo apt-get install -y tidy

# # install and enable xsl
# sudo apt-get install -y xsl

# # install mysql and give password to installer
# sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
# sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
# sudo apt-get -y install mysql-server
# sudo apt-get install php5-mysql

# # install phpmyadmin and give password(s) to installer
# # for simplicity I'm using the same password for mysql and phpmyadmin
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
# sudo apt-get -y install phpmyadmin

# # setup hosts file
# VHOST=$(cat <<EOF
# <VirtualHost *:80>
    # DocumentRoot "/var/www/html/${PROJECTFOLDER}"
    # <Directory "/var/www/html/${PROJECTFOLDER}">
        # AllowOverride All
        # Require all granted
    # </Directory>
# </VirtualHost>
# EOF
# )
# echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# # enable mod_rewrite
# sudo a2enmod rewrite

# # restart apache
# service apache2 restart

# # install git
# sudo apt-get -y install git

# # install Composer
# curl -s https://getcomposer.org/installer | php
# mv composer.phar /usr/local/bin/composer