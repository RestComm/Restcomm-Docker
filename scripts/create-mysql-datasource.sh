#!/bin/bash
## Description : Installs MariaDB driver as a JBoss module.
##				 Creates a datasource for MariaDB. Use config-mariadb script to activate 
##				 and configure the datasource.
## Dependencies: 
##				 1. RESTCOMM_HOME variable must be set.
## Author: Henrique Rosa

# Validate RESTCOMM_HOME
RESTCOMM_HOME=/opt/Restcomm-JBoss-AS7

if [ -z "$RESTCOMM_HOME" ]; then
	echo "RESTCOMM_HOME is not defined. Please setup this environment variable and try again."
	exit 1
fi

# Variables
MYSQLDB_MODULE=$RESTCOMM_HOME/modules/system/layers/base/com/mysql/main
STANDALONE_SIP=$RESTCOMM_HOME/standalone/configuration/standalone-sip.xml

# Download and install MariaDB driver as a JBoss module
mkdir -p $MYSQLDB_MODULE
wget http://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.36/mysql-connector-java-5.1.36.jar -O /tmp/mysql-connector-java-5.1.36.jar
cp /tmp/mysql-connector-java-5.1.36.jar $MYSQLDB_MODULE
rm -f /tmp/mysql-connector-java-5.1.36.jar

cat > $MYSQLDB_MODULE/module.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8" ?>
<module xmlns="urn:jboss:module:1.1" name="com.mysql">
    <resources>
        <resource-root path="mysql-connector-java-5.1.36.jar"/>
    </resources>
    <dependencies>
        <module name="javax.api"/>
        <module name="javax.transaction.api"/>
    </dependencies>
</module>
EOF

# Update JBoss configuration to create a MariaDB datasource
grep -q 'driver name="com.mysql"' $FILE || sed -e '/<drivers>/ a\
\                    <driver name="com.mysql" module="com.mysql">\
\			 <driver-class>com.mysql.jdbc.Driver</driver-class>\
\                        <xa-datasource-class>com.mysql.jdbc.jdbc2.optional.MysqlXADataSource</xa-datasource-class>\
\                    </driver>' \
    -e '/<datasources>/ a\
\                <datasource jta="true" jndi-name="java:/MySqlDS" pool-name="MySqlDS_Pool" enabled="true" use-java-context="true" use-ccm="true"> \
\                    <connection-url>jdbc:mysql://localhost:3306/restcomm</connection-url> \
\                    <driver>com.mysql</driver> \
\                    <transaction-isolation>TRANSACTION_READ_COMMITTED</transaction-isolation> \
\                    <pool> \
\                        <min-pool-size>100</min-pool-size> \
\                        <max-pool-size>200</max-pool-size> \
\                    </pool> \
\                    <security> \
\                        <user-name>telestax</user-name> \
\                        <password>m0b1c3nt5</password> \
\                    </security> \
\                    <statement> \
\                        <prepared-statement-cache-size>100</prepared-statement-cache-size> \
\                        <share-prepared-statements/> \
\                    </statement> \
\                </datasource>' $STANDALONE_SIP > $STANDALONE_SIP.bak
mv $STANDALONE_SIP.bak $STANDALONE_SIP

echo "create mysql datasource done"
