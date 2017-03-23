#!/usr/bin/env bash

if [ $SETUP_BTM_DB = true ]; then
	echo "*************** Getting Default DB Configs ***************"

	#configfile=/dbconfig.conf
	source "/vagrant/setup/btm-db/btm_db.sh"

	#echo "BTM_DB_STAFF: " $BTM_DB_STAFF
	
	echo -e "\n--- Setting up our MySQL user and db ---\n"
	# mysql -uroot -p$DBPASSWD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
	# mysql -uroot -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'" > /vagrant/vm_build.log 2>&1

	echo -e "\n--- Setting up our MySQL user and db ---\n"
	echo -e "\n--- Checking for Previous Database Setup ---\n"

	# DB updates, user gets created, but something with granting privileges on the db failed
	if [ ! -f /var/log/btmolddatabasesetup ];
	then
		echo -e "\n--- No Database found, beginning BTM Database Setup---\n"
		echo "CREATE USER '$BTM_DB_STAFF'@'localhost' IDENTIFIED BY '$BTM_DB_STAFF_PWD'" | mysql -uroot -p$PASSWORD
		echo "CREATE DATABASE $BTM_DB_NAME" | mysql -uroot -p$PASSWORD
		echo "GRANT ALL ON $BTM_DB_NAME.* TO '$BTM_DB_STAFF'@'localhost'" | mysql -uroot -p$PASSWORD
		echo "flush privileges" | mysql -uroot -p$PASSWORD

		echo "--- Preparing to attach database ---"
		
		touch -f /var/log/btmolddatabasesetup

		if [ -f /vagrant/setup/btm-db/exampledb.sql ];
		then
			echo "--- Beginning database transfer ---"
			mysql -uroot -p$PASSWORD $BTM_DB_NAME < /vagrant/setup/btm-db/exampledb.sql
			
			echo "--- Transfer Complete ---"
			
			echo "GRANT ALL PRIVILEGES ON $BTM_DB_NAME.* TO '$BTM_DB_STAFF'@'localhost'" | mysql -uroot -p$PASSWORD
			echo "flush privileges" | mysql -uroot -p$PASSWORD

			echo "--- Privileges flushed ---"
		fi
		
	fi

fi
