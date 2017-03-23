#!/usr/bin/env bash

configfile=/dbconfig.conf

cat $configfile | while read -a HR ; do

  [[ -z ${HR[0]} ]] && continue  # skip empty lines

  DBHOST=${HR[0]}
  DBNAME=${HR[1]}
  DBUSER=${HR[2]}
  DBPASSWD=${HR[3]}
#  HOST2=${HR[4]}
#  PW2=${HR[5]}

#  imapsync \
#  --buffersize 8192000 --nosyncacls --subscribe --syncinternaldates --IgnoreSizeErrors \
#  --host1 $DBHOST --user1 $DBUSER --password1 $DBPASSWD --ssl1 --port1 993 --noauthmd5 \
#  --host2 $HOST2 --user2 $USER2 --password2 $PW2 --ssl2 --port2 993 --noauthmd5 --allowsizemismatch

done

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD" >> /vagrant/vm_build.log 2>&1
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD" >> /vagrant/vm_build.log 2>&1
sudo apt-get -y install mysql-server >> /vagrant/vm_build.log 2>&1
sudo apt-get install php5-mysql >> /vagrant/vm_build.log 2>&1

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true" >> /vagrant/vm_build.log 2>&1
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm >> /vagrant/vm_build.log 2>&1 password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD" >> /vagrant/vm_build.log 2>&1
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD" >> /vagrant/vm_build.log 2>&1
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" >> /vagrant/vm_build.log 2>&1
sudo apt-get -y install phpmyadmin >> /vagrant/vm_build.log 2>&1


echo -e "\n--- Setting up our MySQL user and db ---\n" >> /vagrant/vm_build.log 2>&1
echo -e "\n--- Checking for Previous Database Setup ---\n" >> /vagrant/vm_build.log 2>&1

if [ ! -f /var/log/btmolddatabasesetup ];
then
	echo -e "\n--- No Database found, beginning BTM Database Setup---\n" >> /vagrant/vm_build.log 2>&1
    echo "CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBPASSWD'" | mysql -uroot -p$PASSWORD >> /vagrant/vm_build.log 2>&1
    echo "CREATE DATABASE $DBNAME" | mysql -uroot -p$PASSWORD >> /vagrant/vm_build.log 2>&1
    echo "GRANT ALL ON $DBUSER.* TO '$DBUSER'@'localhost'" | mysql -uroot -p$PASSWORD >> /vagrant/vm_build.log 2>&1
    echo "flush privileges" | mysql -uroot -p$PASSWORD >> /vagrant/vm_build.log 2>&1

    touch /var/log/btmolddatabasesetup >> /vagrant/vm_build.log 2>&1

    if [ -f /vagrant/data/initial.sql ];
    then
        mysql -uroot -p$PASSWORD $DBNAME < /vagrant/exampledb.sql  >> /vagrant/vm_build.log 2>&1
    fi
fi
#mysql -uroot -p$PASSWORD < exampledb.sql >> /vagrant/vm_build.log 2>&1
#mysql -uroot -p$PASSWORD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
#mysql -uroot -p$PASSWORD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'" > /vagrant/vm_build.log 2>&1


# setup hosts file
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
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf  >> /vagrant/vm_build.log 2>&1

# enable mod_rewrite
sudo a2enmod rewrite  >> /vagrant/vm_build.log 2>&1

# restart apache
service apache2 restart  >> /vagrant/vm_build.log 2>&1

# install git
sudo apt-get -y install git >> /vagrant/vm_build.log 2>&1

# install Composer
curl -s https://getcomposer.org/installer | php >> /vagrant/vm_build.log 2>&1
mv composer.phar /usr/local/bin/composer >> /vagrant/vm_build.log 2>&1