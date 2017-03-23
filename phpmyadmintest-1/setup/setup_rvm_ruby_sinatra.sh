#!/usr/bin/env bash

echo "*************** Preparing to setup prerequisites ***************" >> /vagrant/vm_build.log 2>&1
sudo apt-get -y update >> /vagrant/vm_build.log 2>&1
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev >> /vagrant/vm_build.log 2>&1 libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs >> /vagrant/vm_build.log 2>&1

if [ $SETUP_RVM = true ]; then

	echo "*************** getting gpg key for RVM - Ruby Version Manager ***************" >> /vagrant/vm_build.log 2>&1

	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 >> /vagrant/vm_build.log 2>&1

	echo "*************** Use CUrl to download latest RVM stable version over HTTPS ***************" >> /vagrant/vm_build.log 2>&1
	\curl -sSL https://get.rvm.io | sudo  bash -s stable --ruby >> /vagrant/vm_build.log 2>&1

	# need to setup gpg software
	# # Install mpapis public key (might need `gpg2` and or `sudo`)
	# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

	# # Download the installer
	# \curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer
	# \curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc

	# # Verify the installer signature (might need `gpg2`), and if it validates...
	# gpg --verify rvm-installer.asc &&

	# # Run the installer
	# bash rvm-installer stable

	echo "*************** Refreshing RVM in terminal ****************"
	source "/usr/local/rvm/scripts/rvm" >> /vagrant/vm_build.log 2>&1
	
	if [ $SETUP_RUBY = true ]; then
		if [ $SETUP_RUBY240 = true ]; then
			echo "*************** Install Ruby version 2.4.0 ***************" >> /vagrant/vm_build.log 2>&1
			rvm install 2.4.0 >> /vagrant/vm_build.log 2>&1
			rvm use 2.4.0 --default >> /vagrant/vm_build.log 2>&1
			ruby -v >> /vagrant/vm_build.log 2>&1
			
			source /etc/profile
			
			sudo apt-get install -y libqt4-dev libqtwebkit-dev build-essential

			sudo apt-get install -y ruby-dev
			
			#rvm user gemsets
		fi
	fi
fi

if [ $SETUP_SINATRA = true ]; then
	echo "*************** Installing Sinatra from gem ***************" >> /vagrant/vm_build.log 2>&1
	# https://github.com/sinatra/sinatra
	gem install sinatra >> /vagrant/vm_build.log 2>&1
	gem install thin >> /vagrant/vm_build.log 2>&1
fi

if [ $SETUP_RAILS = true];
	echo "*************** Preparing to install Rails dependencies ***************"
	
	sudo apt-get install -y -git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel
fi
