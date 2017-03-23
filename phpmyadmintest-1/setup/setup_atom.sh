#!/usr/bin/env bash

if [ $SETUP_ATOM = true ]; then
	#sudo apt-get install xfce4
	# sudo vim /etc/X11/Xwrapper.config 
	#needed for Atom
	sudo apt-get install -y libxss1
	sudo apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils 
	sudo dpkg -i atom-amd64.deb
	sudo apt-get -f install
	sudo service apache2 restart
fi

if [ $SETUP_CHROME = true ]; then
	sudo apt-get install -y chrome
fi

if [ $SETUP_FIREFOX = true ]; then
	sudo apt-get install -y firefox
fi

# sudo apt-get install xfce4
# sudo vim /etc/X11/Xwrapper.config 
# sudo apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
# VBoxClient-all
# sudo VBoxClient-all
# startxfce4&
# sudo dpkg -i atom-amd64.deb
# sudo apt-get -f install
# startxfce4&
# ifconfig
# sudo service apache restart
# sudo service apache2 restart
# sudo apt-get chrome
# sudo apt-get firefox
# sudo apt-get install firefox
# firefox
# ls
# cd ..
# ls
# cd Down
# cd Downloads/
# sudo dpkg -i atom-amd64.deb
# sudo apt-get -f install
# firefox
# cd
# ls
# cd ..
# cd /var/www/html/
# ls
# cd fundamentals_of_web_programming/
# cd spriggly-wiggly/
# bundle install
# gem install addressable -v '2.4.0'
# export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
# gem install addressable -v '2.4.0'
# bundle install
# clear
# bundle install
# sudo apt-get install ruby-dev
# bundle install
# clear
# sudo apt-get install ruby-dev
# bundle install
# gem install json -v '1.8.3'
# clear
# gem install json -v '1.8.3'
# sudo gem install rake
# clear
# gem install json -v '1.8.3'
# gem install rake
# clear
# gem install json -v '1.8.3'
# which ruby
# sudo apt-get install libqt4-dev libqtwebkit-dev build-essential
# clear
# bundle install
# gem install json -v '1.8.3'
# clear
# gem install json -v '1.8.3'
# gem help
# gem list --local
# gem help
# gem list --local
# gem install json -v '1.8.3'
# bundle update
# atom .
# ls
# atom .
# atom --version
# pkcon install libXScrnSaver
# sudo pkcon install libXScrnSaver
# pkcon install libXScrnSaver
# eopkg install libxscrnsaver
# apt-get libxscrnsaver
# apt-get install libxscrnsaver
# sudo apt-get install libxscrnsaver
# atom --version
# atom .
# sudo apt-get install libxss1
# sudo aptitude search libXss
# atom .
# ls
# bundle exec rerun 'ruby spriggly_wiggly_web_app.rb'
