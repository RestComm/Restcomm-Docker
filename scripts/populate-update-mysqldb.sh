#!/bin/bash

if mysql -u $2 -p$3 -h $1 -e "SELECT * FROM \`$4\`.restcomm_clients;" $database; then
        # Update config settings
        echo "Database already populated"
else
	echo "Database not populated, importing schema and updating config file"
	echo "Create RestComm Database"	
	echo "Configuring RestComm Database MySQL"
	FILE=/opt/Restcomm-JBoss-AS7/standalone/deployments/restcomm.war/WEB-INF/scripts/mariadb/init.sql
	mysql -u $2 -p$3 -h $1 < $FILE
	mysql -u $2 -p$3 -h $1 --execute='show databases;'
	mysql -u $2 -p$3 -h $1 --execute='show tables;' $4;
fi
  echo "Database population done"