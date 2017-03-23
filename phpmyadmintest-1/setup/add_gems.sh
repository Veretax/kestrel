#!/usr/bin/env bash

if [ $ADD_GEM_BUNDLER = true ]; then
	echo "*************** Gem Install Bundler ***************" >> /vagrant/vm_build.log 2>&1
	gem install bundler >> /vagrant/vm_build.log 2>&1
fi

if [ $ADD_GEM_RACK_PROTECTION = true ] ; then
	echo "*************** Gem Install Rack-Protection ***************" >> /vagrant/vm_build.log 2>&1
	# https://github.com/sinatra/sinatra/tree/master/rack-protection
	gem install rack-protection >> /vagrant/vm_build.log 2>&1
fi

if [ $ADD_GEM_HAML = true ] ; then
	echo "*************** Gem Install HAML - HTML Abstraction Markup Language ***************" >> /vagrant/vm_build.log 2>&1
	# http://haml.info/
	gem install haml >> /vagrant/vm_build.log 2>&1
fi

if [ $ADD_GEM_ERUBIS = true ] ; then
	echo "*************** Gem Install Erubis ***************" >> /vagrant/vm_build.log 2>&1
	# http://www.kuwata-lab.com/erubis/
	gem install erubis >> /vagrant/vm_build.log 2>&1
fi

if [ $ADD_GEM_BUILDER = true ] ; then
	echo "*************** Gem Install Builder ***************" >> /vagrant/vm_build.log 2>&1
	# https://github.com/jimweirich/builder
	gem install builder >> /vagrant/vm_build.log 2>&1
fi

if [ $ADD_GEM_NOKOGIRI = true ] ; then
	echo "*************** Gem Install Nokogiri ***************" >> /vagrant/vm_build.log 2>&1
	#http://www.nokogiri.org/
	gem install nokogiri >> /vagrant/vm_build.log 2>&1
	#sudo apt-get install build-essential patch
	#sudo apt-get install ruby-dev zlib1g-dev liblvzma-dev
fi

if [ $ADD_GEM_SASS = true ] ; then
	echo "*************** Gem Install Sass ***************" >> /vagrant/vm_build.log 2>&1
	#http://sass-lang.com/
	sudo su -c "gem install sass" >> /vagrant/vm_build.log 2>&1
fi

if [ $ADD_NPM_LESS = true ] ; then
	echo "*************** NPM Install Less ***************" >> /vagrant/vm_build.log 2>&1
	# http://lesscss.org/
	gpm install -g less >> /vagrant/vm_build.log 2>&1
fi

