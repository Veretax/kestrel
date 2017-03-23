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
	echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf >> /vagrant/vm_build.log 2>&1


	echo "************** Enabling Apache Mod-Rewrite **************" >> /vagrant/vm_build.log 2>&1

	# enable mod_rewrite
	sudo a2enmod rewrite >> /vagrant/vm_build.log 2>&1


	echo -e "\n--- We definitly need to see the PHP errors, turning them on ---\n" >> /vagrant/vm_build.log 2>&1

	sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/apache2/php.ini >> /vagrant/vm_build.log 2>&1

	sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/apache2/php.ini >> /vagrant/vm_build.log 2>&1


	echo -e "\n--- Restarting Apache ---\n" >> /vagrant/vm_build.log 2>&1

	service apache2 restart >> /vagrant/vm_build.log 2>&1

	# restart apache
	echo "************** Preparing to Restart Apache 2 **************" >> /vagrant/vm_build.log 2>&1

	service apache2 restart >> /vagrant/vm_build.log 2>&1

	
fi
