if mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -e "SELECT * FROM \`$MYSQL_SCHEMA\`.restcomm_clients;" $database; then
        # Update config settings
        echo "Database already populated"
else
	echo "Database not populated, importing schema and updating config file"
	echo "Create RestComm Database"	
	echo "Configuring RestComm Database MySQL"
	FILE=/opt/Mobicents-Restcomm-JBoss-AS7/standalone/deployments/restcomm.war/WEB-INF/scripts/mariadb/init.sql
	mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST < $FILE
	mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST --execute='show databases;'
	mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST --execute='show tables;' $MYSQL_SCHEMA;
fi
