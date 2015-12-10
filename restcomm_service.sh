#!/bin/bash
#Maintainer George Vagenas - gvagenas@telestax.com
#Maintainer Jean Deruelle - jean.deruelle@telestax.com

BASEDIR=/opt/Mobicents-Restcomm-JBoss-AS7

echo "Will check for enviroment variable and configure restcomm.conf"

if [ -n "$STATIC_ADDRESS" ]; then
  echo "STATIC_ADDRESS $STATIC_ADDRESS"
  sed -i "s/STATIC_ADDRESS=.*/STATIC_ADDRESS=$STATIC_ADDRESS/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$OUTBOUND_PROXY" ]; then
  echo "OUTBOUND_PROXY $OUTBOUND_PROXY"
  sed -i "s/OUTBOUND_PROXY=.*/OUTBOUND_PROXY=$OUTBOUND_PROXY/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$OUTBOUND_PROXY_USERNAME" ]; then
  echo "OUTBOUND_PROXY_USERNAME $OUTBOUND_PROXY_USERNAME"
  sed -i "s/OUTBOUND_PROXY_USERNAME=.*/OUTBOUND_PROXY_USERNAME=$OUTBOUND_PROXY_USERNAME/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$OUTBOUND_PROXY_PASSWORD" ]; then
  echo "OUTBOUND_PROXY_PASSWORD $OUTBOUND_PROXY_PASSWORD"
  sed -i "s/OUTBOUND_PROXY_PASSWORD=.*/OUTBOUND_PROXY_PASSWORD=$OUTBOUND_PROXY_PASSWORD/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$MEDIASERVER_LOWEST_PORT" ]; then
  echo "MEDIASERVER_LOWEST_PORT $MEDIASERVER_LOWEST_PORT"
  sed -i "s/MEDIASERVER_LOWEST_PORT=.*/MEDIASERVER_LOWEST_PORT=$MEDIASERVER_LOWEST_PORT/" $BASEDIR/bin/restcomm/restcomm.conf
else
  MEDIASERVER_LOWEST_PORT='65000'
  echo "MEDIASERVER_LOWEST_PORT $MEDIASERVER_LOWEST_PORT"
  sed -i "s/MEDIASERVER_LOWEST_PORT=.*/MEDIASERVER_LOWEST_PORT=$MEDIASERVER_LOWEST_PORT/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$MEDIASERVER_HIGHEST_PORT" ]; then
  echo "MEDIASERVER_HIGHEST_PORT $MEDIASERVER_HIGHEST_PORT"
  sed -i "s/MEDIASERVER_HIGHEST_PORT=.*/MEDIASERVER_HIGHEST_PORT=$MEDIASERVER_HIGHEST_PORT/" $BASEDIR/bin/restcomm/restcomm.conf
else
  MEDIASERVER_HIGHEST_PORT='65535'
  echo "MEDIASERVER_HIGHEST_PORT $MEDIASERVER_HIGHEST_PORT"
  sed -i "s/MEDIASERVER_HIGHEST_PORT=.*/MEDIASERVER_HIGHEST_PORT=$MEDIASERVER_HIGHEST_PORT/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$PROVISION_PROVIDER" ]; then
  echo "PROVISION_PROVIDER $PROVISION_PROVIDER"
  sed -i "s/PROVISION_PROVIDER=.*/PROVISION_PROVIDER=$PROVISION_PROVIDER/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_LOGIN" ]; then
  echo "DID_LOGIN $DID_LOGIN"
  sed -i "s/DID_LOGIN=.*/DID_LOGIN=$DID_LOGIN/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_PASSWORD" ]; then
  echo "DID_PASSWORD $DID_PASSWORD"
  sed -i "s/DID_PASSWORD=.*/DID_PASSWORD=$DID_PASSWORD/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$SMS_PREFIX" ]; then
  echo "SMS_PREFIX $SMS_PREFIX"
  sed -i "s/SMS_PREFIX=.*/SMS_PREFIX=$SMS_PREFIX/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$SMPP_TYPE" ]; then
  echo "SMPP_TYPE $SMPP_TYPE"
  sed -i "s/SMPP_ACTIVATE=.*/SMPP_ACTIVATE='true'/" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s/SMPP_SYSTEM_ID=.*/SMPP_SYSTEM_ID='$DID_LOGIN'/" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s/SMPP_PASSWORD=.*/SMPP_PASSWORD='$DID_PASSWORD'/" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s/SMPP_SYSTEM_TYPE=.*/SMPP_SYSTEM_TYPE='$SMPP_TYPE'/" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s/SMPP_PEER_IP=.*/SMPP_PEER_IP='smpp0.nexmo.com'/" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s/SMPP_PEER_PORT=.*/SMPP_PEER_PORT='8000'/" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|<connection activateAddressMapping=\"false\" sourceAddressMap=\"\" destinationAddressMap=\"\" tonNpiValue=\"1\">|<connection activateAddressMapping=\"false\" sourceAddressMap=\"6666\" destinationAddressMap=\"7777\" tonNpiValue=\"1\">|" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml
fi

if [ -n "$DID_ENDPOINT" ]; then
  echo "DID_ENDPOINT $DID_ENDPOINT"
  sed -i "s/DID_ENDPOINT=.*/DID_ENDPOINT=$DID_ENDPOINT/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_SITEID" ]; then
  echo "DID_SITEID $DID_SITEID"
  sed -i "s/DID_SITEID=.*/DID_SITEID=$DID_SITEID/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_ACCOUNTID" ]; then
  echo "DID_ACCOUNTID $DID_ACCOUNTID"
  sed -i "s/DID_ACCOUNTID=.*/DID_ACCOUNTID=$DID_ACCOUNTID/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$INTERFAX_USER" ]; then
  echo "INTERFAX_USER $INTERFAX_USER"
  sed -i "s/INTERFAX_USER=.*/INTERFAX_USER=$INTERFAX_USER/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$INTERFAX_PASSWORD" ]; then
  echo "INTERFAX_PASSWORD $INTERFAX_PASSWORD"
  sed -i "s/INTERFAX_PASSWORD=.*/INTERFAX_PASSWORD=$INTERFAX_PASSWORD/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ISPEECH_KEY" ]; then
  echo "ISPEECH_KEY $ISPEECH_KEY"
  sed -i "s/ISPEECH_KEY=.*/ISPEECH_KEY=$ISPEECH_KEY/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$VOICERSS_KEY" ]; then
  echo "VoiceRSS key: $VOICERSS_KEY"
  sed -i "s/VOICERSS_KEY=.*/VOICERSS_KEY=$VOICERSS_KEY/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ACAPELA_APPLICATION" ]; then
  echo "ACAPELA_APPLICATION $ACAPELA_APPLICATION"
  sed -i "s/ACAPELA_APPLICATION=.*/ACAPELA_APPLICATION=$ACAPELA_APPLICATION/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ACAPELA_LOGIN" ]; then
  echo "ACAPELA_LOGIN $ACAPELA_LOGIN"
  sed -i "s/ACAPELA_LOGIN=.*/ACAPELA_LOGIN=$ACAPELA_LOGIN/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ACAPELA_PASSWORD" ]; then
  echo "ACAPELA_PASSWORD $ACAPELA_PASSWORD"
  sed -i "s/ACAPELA_PASSWORD=.*/ACAPELA_PASSWORD=$ACAPELA_PASSWORD/" $BASEDIR/bin/restcomm/restcomm.conf
fi

wget --auth-no-challenge -qc https://mobicents.ci.cloudbees.com/job/Olympus/lastSuccessfulBuild/artifact/target/olympus.war -P $BASEDIR
rm -rf $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/lib/nist-sdp-*.jar

mkdir $BASEDIR/standalone/deployments/olympus-exploded.war
unzip $BASEDIR/standalone/deployments/olympus.war -d $BASEDIR/standalone/deployments/olympus-exploded.war/
rm -f $BASEDIR/standalone/deployments/olympus.war
mv -f $BASEDIR/standalone/deployments/olympus-exploded.war $BASEDIR/standalone/deployments/olympus.war

if [ -n "$S3_BUCKET_NAME" ]; then
  echo "S3_BUCKET_NAME $S3_BUCKET_NAME S3_ACCESS_KEY $S3_ACCESS_KEY S3_SECURITY_KEY $S3_SECURITY_KEY"
  sed -i "/<amazon-s3>/ {
		N; s|<enabled>.*</enabled>|<enabled>true</enabled>|
		N; s|<bucket-name>.*</bucket-name>|<bucket-name>$S3_BUCKET_NAME</bucket-name>|
		N; s|<folder>.*</folder>|<folder>logs</folder>|
		N; s|<access-key>.*</access-key>|<access-key>$S3_ACCESS_KEY</access-key>|
		N; s|<security-key>.*</security-key>|<security-key>$S3_SECURITY_KEY</security-key>|
	}" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml
fi

if [ -n "$SMTP_USER" ]; then
  echo "SMTP_USER $SMTP_USER SMTP_PASSWORD $SMTP_PASSWORD SMTP_HOST $SMTP_HOST"
  sed -i "/<smtp-notify>/ {
		N; s|<host>.*</host>|<host>$SMTP_HOST</host>|
		N; s|<user>.*</user>|<user>$SMTP_USER</user>|
		N; s|<password>.*</password>|<password>$SMTP_PASSWORD</password>|
	}" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml

  sed -i "/<smtp-service>/ {
		N; s|<host>.*</host>|<host>$SMTP_HOST</host>|
		N; s|<user>.*</user>|<user>$SMTP_USER</user>|
		N; s|<password>.*</password>|<password>$SMTP_PASSWORD</password>|
	}" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml
fi

if [ -n "$MYSQL_USER" ]; then
  echo "MYSQL_USER $MYSQL_USER MYSQL_HOST $MYSQL_HOST MYSQL_SCHEMA $MYSQL_SCHEMA"
  grep -q 'MYSQL_HOST=' $BASEDIR/bin/restcomm/restcomm.conf || echo "MYSQL_HOST=$MYSQL_HOST" >> $BASEDIR/bin/restcomm/restcomm.conf
  grep -q 'MYSQL_USER=' $BASEDIR/bin/restcomm/restcomm.conf ||  echo "MYSQL_USER=$MYSQL_USER" >> $BASEDIR/bin/restcomm/restcomm.conf
  grep -q 'MYSQL_PASSWORD=' $BASEDIR/bin/restcomm/restcomm.conf ||  echo "MYSQL_PASSWORD=$MYSQL_PASSWORD" >> $BASEDIR/bin/restcomm/restcomm.conf
  if [ -n "$MYSQL_SCHEMA" ]; then
	grep -q 'MYSQL_SCHEMA=' $BASEDIR/bin/restcomm/restcomm.conf || echo "MYSQL_SCHEMA=$MYSQL_SCHEMA" >> $BASEDIR/bin/restcomm/restcomm.conf
  else
	$MYSQL_SCHEMA="restcomm"
	  grep -q 'MYSQL_SCHEMA=' $BASEDIR/bin/restcomm/restcomm.conf || echo "MYSQL_SCHEMA=$MYSQL_SCHEMA" >> $BASEDIR/bin/restcomm/restcomm.conf
  fi
  echo "MYSQL_USER $MYSQL_USER MYSQL_HOST $MYSQL_HOST MYSQL_SCHEMA $MYSQL_SCHEMA"
  sed -i "s|restcomm;|$MYSQL_SCHEMA|" $BASEDIR/bin/restcomm/populate-update-mysqldb.sh
  sed -i "s|restcomm;|$MYSQL_SCHEMA|" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/scripts/mariadb/init.sql
  source $BASEDIR/bin/restcomm/populate-update-mysqldb.sh $MYSQL_HOST $MYSQL_USER $MYSQL_PASSWORD $MYSQL_SCHEMA
fi

if [ -n "$TRUSTSTORE_FILE" ]; then
	sed -i "s/TRUSTSTORE_FILE=.*/TRUSTSTORE_FILE='$TRUSTSTORE_FILE'/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$TRUSTSTORE_PASSWORD" ]; then
	sed -i "s/TRUSTSTORE_PASSWORD=.*/TRUSTSTORE_PASSWORD='$TRUSTSTORE_PASSWORD'/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$TRUSTSTORE_ALIAS" ]; then
	sed -i "s/TRUSTSTORE_ALIAS=.*/TRUSTSTORE_ALIAS='$TRUSTSTORE_ALIAS'/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$SSL_MODE" ]; then
	sed -i "s/SSL_MODE=.*/SSL_MODE='$SSL_MODE'/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$SECURE" ]; then
  echo "SECURE $SECURE"

  # Add StartComm certificate to the truststore to avoid SSL Exception when fetching the URL
  keytool -importcert -alias startssl -keystore /usr/lib/jvm/java-7-oracle/jre/lib/security/cacerts -storepass changeit -file $BASEDIR/ca-startcom.der -noprompt
  # Add JRE Unlimited Cryptography
  #cp -rf $BASEDIR/local_policy.jar /usr/lib/jvm/java-7-oracle/jre/lib/security/local_policy.jar
  #cp -rf $BASEDIR/US_export_policy.jar /usr/lib/jvm/java-7-oracle/jre/lib/security/US_export_policy.jar

  sed -i "s/DISABLE_HTTP=.*/DISABLE_HTTP='true'/" $BASEDIR/bin/restcomm/restcomm.conf

  # https://wiki.apache.org/tomcat/Security/Ciphers
  #sed -i "s|TLS_RSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_AES_128_CBC_SHA256,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA|TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_AES_128_CBC_SHA256,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA|" $BASEDIR/bin/restcomm/autoconfig.d/config-sip-connectors.sh
  sed -i "s|protocol=\"TLSv1,TLSv1.1,TLSv1.2\"|protocol=\"TLSv1,TLSv1.1,TLSv1.2,SSLv2Hello\"|" $BASEDIR/standalone/configuration/standalone-sip.xml
  grep -q 'ephemeralDHKeySize' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Djdk.tls.ephemeralDHKeySize=2048|" $BASEDIR/bin/standalone.conf
  grep -q 'allowLegacyHelloMessages' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Dsun.security.ssl.allowLegacyHelloMessages=false -Djsse.enableSNIExtension=false|" $BASEDIR/bin/standalone.conf
  grep -q 'https.protocols' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Dhttps.protocols=TLSv1.1,TLSv1.2|" $BASEDIR/bin/standalone.conf
#  grep -q 'javax.net.debug' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Djavax.net.debug=ssl,handshake|" $BASEDIR/bin/standalone.conf

  grep -q 'connector name="sip-wss"' $BASEDIR/standalone/configuration/standalone-sip.xml || sed -i '/connector name=\"sip-ws\".*/ a \
	\    <connector name="sip-wss" protocol="SIP/2.0" scheme="sip" socket-binding="sip-wss"/>
	' $BASEDIR/standalone/configuration/standalone-sip.xml
  if [ -n "$STATIC_ADDRESS" ]; then
	sed -i "s|<connector name=\"sip-wss\" .*/>|<connector name=\"sip-wss\" protocol=\"SIP/2.0\" scheme=\"sip\" socket-binding=\"sip-wss\" use-static-address=\"true\" static-server-address=\"$STATIC_ADDRESS\" static-server-port=\"5083\"/>|" $BASEDIR/standalone/configuration/standalone-sip.xml
  fi
  grep -q 'binding name="sip-wss"' $BASEDIR/standalone/configuration/standalone-sip.xml || sed -i '/binding name=\"sip-ws\".*/ a \
	\<socket-binding name="sip-wss" port="5083"/>
	' $BASEDIR/standalone/configuration/standalone-sip.xml
  grep -q 'gov.nist.javax.sip.TLS_CLIENT_AUTH_TYPE=Disabled' $BASEDIR/standalone/configuration/mss-sip-stack.properties || sed -i "/org.mobicents.ha.javax.sip.LOCAL_SSL_PORT=8443/ a \
\gov.nist.javax.sip.TLS_CLIENT_AUTH_TYPE=Disabled\
\javax.net.ssl.keyStore=$TRUSTSTORE_FILE\
\javax.net.ssl.keyStorePassword=$TRUSTSTORE_PASSWORD\
\javax.net.ssl.trustStorePassword=$TRUSTSTORE_PASSWORD\
\javax.net.ssl.trustStore=$TRUSTSTORE_FILE\
\javax.net.ssl.keyStoreType=JKS
	" $BASEDIR/standalone/configuration/mss-sip-stack.properties
  sed -i "s|ws:|wss:|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
  sed -i "s|5082|5083|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
fi

if [ -n "$USE_STANDARD_PORTS" ]; then
  echo "USE_STANDARD_PORTS $USE_STANDARD_PORTS"
  sed -i "s|8080|80|" $BASEDIR/standalone/configuration/standalone-sip.xml
  sed -i "s|8080|80|" $BASEDIR/standalone/configuration/mss-sip-stack.properties
  sed -i "s|8443|443|" $BASEDIR/standalone/configuration/standalone-sip.xml
  sed -i "s|8443|443|" $BASEDIR/standalone/configuration/mss-sip-stack.properties
  sed -i "s|:8080||" $BASEDIR/bin/restcomm/autoconfig.d/config-restcomm.sh
  sed -i "s|5080|5060|" $BASEDIR/standalone/configuration/standalone-sip.xml
  sed -i "s|5081|5061|" $BASEDIR/standalone/configuration/standalone-sip.xml
  sed -i "s|5082|5062|" $BASEDIR/standalone/configuration/standalone-sip.xml
  sed -i "s|5083|5063|" $BASEDIR/standalone/configuration/standalone-sip.xml
  sed -i "s|5080|5060|" $BASEDIR/bin/restcomm/autoconfig.d/config-sip-connectors.sh
  sed -i "s|5081|5061|" $BASEDIR/bin/restcomm/autoconfig.d/config-sip-connectors.sh
  sed -i "s|5082|5062|" $BASEDIR/bin/restcomm/autoconfig.d/config-sip-connectors.sh
  sed -i "s|:5080||" $BASEDIR/bin/restcomm/autoconfig.d/config-restcomm.sh
  sed -i "s|5082|5062|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
  sed -i "s|5083|5063|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
fi

if [ -n "$NFS_LOCATION" ]; then
  echo "NFS_LOCATION $NFS_LOCATION"
  #exec /etc/init.d/rpcbind start
  #mkdir -p /mnt/nfs/home/rvd/workspace
  #mount -t nfs $NFS_ADDRESS:$NFS_LOCATION /mnt/nfs/home/rvd/workspace
  #df -h
  #mount
  sed -i "s|<workspaceLocation>.*</workspaceLocation>|<workspaceLocation>$NFS_LOCATION</workspaceLocation>|" $BASEDIR/standalone/deployments/restcomm-rvd.war/WEB-INF/rvd.xml
fi

if [ -n "$LOG_LEVEL" ]; then
  echo "LOG_LEVEL $LOG_LEVEL"
  sed -i "s|<logger category=\"org.mobicents.servlet.sip\">|<logger category=\"org.mobicents.servlet\">|" $BASEDIR/standalone/configuration/standalone-sip.xml
  sed -i "/<logger category=\"org.mobicents.servlet\">/ {
		N; s|<level name=\".*\"/>|<level name=\"$LOG_LEVEL\"/>|
	}" $BASEDIR/standalone/configuration/standalone-sip.xml
fi

if [ -n "$LOGS_LOCATION" ]; then
  echo "LOGS_LOCATION $LOGS_LOCATION"
  rm -rf $LOGS_LOCATION/*
  nohup date +'%Y-%m-%d_%H:%M:%S-%Z' | xargs -I {} bash -c "tcpdump -pni eth0 -t -n -s 0 \"portrange 5060-5063 or (udp and portrange 65000-65535) or port 80 or port 443 or port 9990\" -C 100 -W 40 -w $LOGS_LOCATION/restcomm_trace_{}.cap"&
  sed -i "s|<file relative-to=\"jboss.server.log.dir\" path=\".*\"\/>|<file path=\"$LOGS_LOCATION\/mss-server.log\"\/>|" $BASEDIR/standalone/configuration/standalone-sip.xml
  sed -i "s|param name=\"File\" value=\".*\"|param name=\"File\" value=\"$LOGS_LOCATION\/mms-server.log\"|" $BASEDIR/mediaserver/conf/log4j.xml
fi

if [ -n "$HOSTNAME" ]; then
  echo "HOSTNAME $HOSTNAME"
  sed -i "s|<hostname>.*<\/hostname>|<hostname>$HOSTNAME<\/hostname>|" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml
fi

grep -q 'gather-statistics' $BASEDIR/standalone/configuration/standalone-sip.xml || sed -i "s|congestion-control-interval=\".*\"|& gather-statistics=\"true\"|" $BASEDIR/standalone/configuration/standalone-sip.xml

sed -i "s|#gov.nist.javax.sip.SIP_MESSAGE_VALVE=org.mobicents.ext.javax.sip.congestion.CongestionControlMessageValve|gov.nist.javax.sip.SIP_MESSAGE_VALVE=org.mobicents.ext.javax.sip.congestion.CongestionControlMessageValve|" $BASEDIR/standalone/configuration/mss-sip-stack.properties
sed -i "s|#org.mobicents.ext.javax.sip.congestion.CONGESTION_CONTROL_MONITOR_INTERVAL=.*|org.mobicents.ext.javax.sip.congestion.CONGESTION_CONTROL_MONITOR_INTERVAL=-1|" $BASEDIR/standalone/configuration/mss-sip-stack.properties
grep -q 'org.mobicents.ext.javax.sip.congestion.SIP_SCANNERS.*' $BASEDIR/standalone/configuration/mss-sip-stack.properties || sed -i '/gov.nist.javax.sip.SIP_MESSAGE_VALVE.*/ a \
\org.mobicents.ext.javax.sip.congestion.SIP_SCANNERS=sipvicious,sipcli,friendly-scanner,VaxSIPUserAgent
	' $BASEDIR/standalone/configuration/mss-sip-stack.properties

grep -q 'jboss.bind.address.management' $BASEDIR/bin/restcomm/start-restcomm.sh || sed -i "s|RESTCOMM_HOME/bin/standalone.sh -b .*|RESTCOMM_HOME/bin/standalone.sh -b \$bind_address -Djboss.bind.address.management=\$bind_address|" $BASEDIR/bin/restcomm/start-restcomm.sh

wget --auth-no-challenge -qc https://raw.githubusercontent.com/Mobicents/RestComm/0dfe74423b2099a87a54ebc576b6568c596016fd/restcomm/configuration/mms-server-beans.xml -P $BASEDIR
wget --auth-no-challenge -qc https://raw.githubusercontent.com/Mobicents/RestComm/0dfe74423b2099a87a54ebc576b6568c596016fd/restcomm/configuration/config-scripts/as7-config-scripts/restcomm/autoconfig.d/dont-config-mobicents-ms.sh -P $BASEDIR
cp -rf $BASEDIR/mms-server-beans.xml $BASEDIR/mediaserver/deploy/server-beans.xml
cp -rf $BASEDIR/dont-config-mobicents-ms.sh $BASEDIR/bin/restcomm/autoconfig.d/dont-config-mobicents-ms.sh

export RUN_DOCKER=true

chmod +x $BASEDIR/bin/*.sh
chmod +x $BASEDIR/bin/restcomm/*.sh

exec $BASEDIR/bin/restcomm/start-restcomm.sh
grep -q 'telestax' $BASEDIR/standalone/configuration/mgmt-users.properties || exec $BASEDIR/bin/add-user.sh telestax "RestComm" -s
