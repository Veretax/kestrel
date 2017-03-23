#!/usr/bin/env bash

if [ $SETUP_GIT = true ]; then
	echo "************** Configuring Git ***************" >> /vagrant/vm_build.log 2>&1

	sudo apt-get -y update >> /vagrant/vm_build.log 2>&1
	sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs >> /vagrant/vm_build.log 2>&1

	git config --global color.ui true >> /vagrant/vm_build.log 2>&1
	git config --global user.name "Timothy Western" >> /vagrant/vm_build.log 2>&1
	git config --global user.email "veretax@gmail.com" >> /vagrant/vm_build.log 2>&1
	
	# https://help.github.com/articles/connecting-to-github-with-ssh/
	
	RSAFILE=""
	DIR="/.ssh"
	
	#init
	# look for empty directory
	if [ "$(ls -A $DIR)" ] ; then
		echo "************** Warning! .SSH directory is not-empty **************" >> /vagrant/vm_build.log 2>&1
	else
		echo "*************** $DIR is Empty ****************" >> /vagrant/vm_build.log 2>&1
		echo "*************** Installing gemoview ***************" >> /vagrant/vm_build.log 2>&1
		apt-get install -y geomview >> /vagrant/vm_build.log 2>&1

		echo "*************** Setting up Keys *****************" >> /vagrant/vm_build.log 2>&1
		
		ssh-keygen -t rsa -b 4096 -C "veretax@gmail.com" >> /vagrant/vm_build.log 2>&1
		eval $(ssh-agent -s) >> /vagrant/vm_build.log 2>&1

		ssh-add ~/.ssh/id_rsa >> /vagrant/vm_build.log 2>&1
		#ls -al ~/.ssh
		
		clip < ~/.ssh/id_rsa.pub >> /vagrant/vm_build.log 2>&1
	fi
	

fi

echo "*************** Git Setup Completed ***************" >> /vagrant/vm_build.log 2>&1
