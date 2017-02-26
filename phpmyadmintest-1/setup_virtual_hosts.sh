#!/usr/bin/env bash

# setup hosts file
if [ $SETUP_APACHE_VIRTUAL_HOSTS = true] ; then

	echo "*************** Setting up Apache Virtual Hosts **************"
	VHOST=$(cat <<EOF
	<VirtualHost *:80>
		DocumentRoot "/var/www/html/${PROJECTFOLDER}"
		<Directory "/var/www/html/${PROJECTFOLDER}">
			AllowOverride All
			Require all granted
		</Directory>
	</VirtualHost>
	EOF
	)
	echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

	echo "************** Enabling Apache Mod-Rewrite **************"
	# enable mod_rewrite
	sudo a2enmod rewrite


	# restart apache
	echo "************** Preparing to Restart Apache 2 **************"
	service apache2 restart
	
fi
