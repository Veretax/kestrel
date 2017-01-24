#!/usr/bin/env bash

cp bash_aliases.txt ~/.bash_aliases
cp bash_rc.txt ~/.bashrc

apt-get update
apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

apt-get install mysql-server php5-mysql

sudo mysql_install_db

sudo mysql_secure_installation

sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt

cp apache2-mods-enabled-dir-conf.txt /etc/apache2/mods-enabled/dir.conf

sudo service apache2 restart

