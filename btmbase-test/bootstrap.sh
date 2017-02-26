#!/usr/bin/env bash

echo "*************** Beginning bootstrap.sh *************** "
# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='12345678'
PROJECTFOLDER='btm-dev'
MYTEST='This Is MyTest'

echo "*************** Checking for Project Folder *************** "
# create project folder
PROJECTPATH="/var/www/html/${PROJECTFOLDER}"

if [ ! -d "${PROJECTPATH}" ]; then
  echo "*************** Creating Project Folder *************** "	
  # Control will enter here if $PROJECTPATH exists.
  sudo mkdir "/var/www/html/${PROJECTFOLDER}"
fi


# Setup Bash Alias and Profile
echo "*************** Preparing to Setup Bash Alias and Profile *************** "
echo "*************** Creating bash_aliases *************** "
cp /vagrant/bash_aliases.txt ~/.bash_aliases

echo "*************** Verifying bash_aliases *************** "

if [ -f ~/.bash_aliases ]; then
    echo "*************** bash_aliases Verified *************** "
fi


echo "*************** Creating .bashrc *************** " 

cp /vagrant/bash_rc.txt ~/.bashrc

echo "*************** Verifying bashrc *************** "

if [ -f ~/.bashrc ]; then
    echo "*************** bashrc Verified *************** "
fi

echo "*************** Reloading .bashrc *************** " 

. .bashrc

echo "*************** end bootstrap.sh *************** "