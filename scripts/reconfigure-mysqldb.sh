#!/bin/bash
## Description: Enables and configures MySQL datasource
## Params:
## 			1. RESTCOMM_VERSION
## Author: Henrique Rosa

# VARIABLES
RESTCOMM_HOME=/opt/Restcomm-JBoss-AS7
RESTCOMM_DEPLOY=$RESTCOMM_HOME/standalone/deployments/restcomm.war

## Description: Configures MyBatis for MySQL
## Parameters : none
configMybatis() {
	FILE=$RESTCOMM_DEPLOY/WEB-INF/conf/mybatis.xml
	
	grep -q '<environment id="mysql">' $FILE || sed -i '/<environments.*>/ a \
	\	<environment id="mysql">\
	\		<transactionManager type="JDBC"/>\
	\		<dataSource type="JNDI">\
	\			<property name="data_source" value="java:/MySqlDS" />\
	\		</dataSource>\
	\	</environment>\
	' $FILE
	
	sed -e '/<environments.*>/ s|default=".*"|default="mysql"|' $FILE > $FILE.bak
	mv $FILE.bak $FILE
	echo 'Activated mybatis environment for MySQL';
}

## Description: Configures MySQL Datasource
## Parameters : 1. Private IP
configureDataSource() {
	FILE=$RESTCOMM_HOME/standalone/configuration/standalone-sip.xml

	# Update DataSource
	grep -q 'MySqlDS' $FILE || sed -e "/<datasource jta=\"true\" jndi-name=\"java:\/MySqlDS\" .*>/ {
		s|<connection-url>.*</connection-url>|<connection-url>jdbc:mysql://$1:3306/$4</connection-url>|
		N
		N
		N
		N
		N
		N
		s|<user-name>.*</user-name>|<user-name>username</user-name>|
		s|<password>.*</password>|<password>password</password>|
	}" $FILE > $FILE.bak
	mv $FILE.bak $FILE
	echo 'Updated MySQL DataSource Configuration'
}

configureMySQLDataSource() {
	FILE=$RESTCOMM_HOME/standalone/configuration/standalone-sip.xml

	if [ -n "$5" ]; then
		#DB failover configuration.
		sed -e "s|<connection-url>.*</connection-url>|<connection-url>jdbc:mysql://$1:3306/$4|jdbc:mysql://$5:3306/$4</connection-url>|g" $FILE > $FILE.bak
	else
		# Update DataSource
		sed -e "s|<connection-url>.*</connection-url>|<connection-url>jdbc:mysql://$1:3306/$4</connection-url>|g" $FILE > $FILE.bak
	fi
	mv $FILE.bak $FILE
	sed -e "s|<user-name>.*</user-name>|<user-name>$2</user-name>|g" $FILE > $FILE.bak
	mv $FILE.bak $FILE	
	sed -e "s|<password>.*</password>|<password>$3</password>|g" $FILE > $FILE.bak
	mv $FILE.bak $FILE		
	echo 'Updated MySQL DataSource Configuration'
}

## Description: Enables MySQL Datasource while disabling the remaining
## Parameters : none
enableDataSource() {
	FILE=$RESTCOMM_HOME/standalone/configuration/standalone-sip.xml
	
	# Disable all datasources but MySQL
	sed -e '/<datasource/ s|enabled="true"|enabled="false"|' \
	    -e '/<datasource.*MySqlDS/ s|enabled=".*"|enabled="true"|' \
	    $FILE > $FILE.bak
	
	mv $FILE.bak $FILE
	echo 'Enabled MySQL datasource'
}

## Description: Configures RestComm DAO manager to use MySQL
## Params: none
configDaoManager() {
	FILE=$RESTCOMM_DEPLOY/WEB-INF/conf/restcomm.xml
	
	sed -e "s|<data-files>.*</data-files>|<data-files></data-files>|g" $FILE > $FILE.bak
	mv $FILE.bak $FILE	
	sed -e "s|<sql-files>.*</sql-files>|<sql-files>\${restcomm:home}/WEB-INF/scripts/mariadb/sql</sql-files>|g" $FILE > $FILE.bak
	mv $FILE.bak $FILE

	echo 'Configured MySQL Dao Manager for MySQL'
}

# MAIN
if [ -n "$MYSQL_USER" ]; then
	echo 'Configuring MySQL datasource... $MYSQL_HOST $MYSQL_SCHEMA $MYSQL_USER'
	#configureDataSource $PRIVATE_IP $MYSQL_SNDHOST
	#configureDataSource localhost $MYSQL_SNDHOST
	enableDataSource
	configMybatis
	configDaoManager
	configureMySQLDataSource $MYSQL_HOST $MYSQL_USER $MYSQL_PASSWORD $MYSQL_SCHEMA $MYSQL_SNDHOST
	echo 'Finished configuring MySQL datasource!'

fi
