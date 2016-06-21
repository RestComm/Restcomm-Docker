#!/bin/bash
#Maintainer George Vagenas - gvagenas@telestax.com
#Maintainer Jean Deruelle - jean.deruelle@telestax.com
#Maintainer Lefteris Banos -liblefty@telestax.com

source /etc/container_environment.sh


BASEDIR=/opt/Restcomm-JBoss-AS7
RESTCOMM_CORE_LOG=$BASEDIR/standalone/log
MMS_LOGS=$BASEDIR/mediaserver/log

echo "Will check for enviroment variable and configure restcomm.conf"

#RestComm Network Configuration
if [ -n "$STATIC_ADDRESS" ]; then
  echo "STATIC_ADDRESS $STATIC_ADDRESS"
  sed -i "s|STATIC_ADDRESS=.*|STATIC_ADDRESS='${STATIC_ADDRESS}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$NET_INTERFACE" ]; then
  echo "NET_INTERFACE $NET_INTERFACE"
  sed -i "s|NET_INTERFACE=.*|NET_INTERFACE='${NET_INTERFACE}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$RESTCOMM_HOSTNAME" ]; then
  echo "HOSTNAME $RESTCOMM_HOSTNAME"
  sed -i "s|RESTCOMM_HOSTNAME=.*|RESTCOMM_HOSTNAME='${RESTCOMM_HOSTNAME}'|" $BASEDIR/bin/restcomm/restcomm.conf
 fi

#MS Network Configuration
if [ -n "$MS_ADDRESS" ]; then
   echo "MS_ADDRESS $MS_ADDRESS"
   sed -i "s|MS_ADDRESS=.*|MS_ADDRESS='${MS_ADDRESS}'|" $BASEDIR/bin/restcomm/restcomm.conf

   #disable internal mediaserver
   MS_EXTERNAL=TRUE
   echo "MS_EXTERNAL $MS_EXTERNAL"
   sed -i "s|MS_EXTERNAL=.*|MS_EXTERNAL='${MS_EXTERNAL}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$MS_COMPATIBILITY_MODE" ]; then
   echo "MS_COMPATIBILITY_MODE $MS_COMPATIBILITY_MODE"
   sed -i "s|MS_COMPATIBILITY_MODE=.*|MS_COMPATIBILITY_MODE='${MS_COMPATIBILITY_MODE}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$MS_NETWORK" ]; then
   echo "MS_NETWORK $MS_NETWORK"
   sed -i "s|MS_NETWORK=.*|MS_NETWORK='${MS_NETWORK}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$MS_SUBNET_MASK" ]; then
   echo "MS_SUBNET_MASK $MS_SUBNET_MASK"
   sed -i "s|MS_SUBNET_MASK=.*|MS_SUBNET_MASK='${MS_SUBNET_MASK}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

#RTP port range configuration.
if [ -n "$MEDIASERVER_LOWEST_PORT" ]; then
  echo "MEDIASERVER_LOWEST_PORT $MEDIASERVER_LOWEST_PORT"
  sed -i "s|MEDIASERVER_LOWEST_PORT=.*|MEDIASERVER_LOWEST_PORT='${MEDIASERVER_LOWEST_PORT}'|" $BASEDIR/bin/restcomm/restcomm.conf
else
  MEDIASERVER_LOWEST_PORT='65000'
  echo "MEDIASERVER_LOWEST_PORT $MEDIASERVER_LOWEST_PORT"
  sed -i "s|MEDIASERVER_LOWEST_PORT=.*|MEDIASERVER_LOWEST_PORT='${MEDIASERVER_LOWEST_PORT}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$MEDIASERVER_HIGHEST_PORT" ]; then
  echo "MEDIASERVER_HIGHEST_PORT $MEDIASERVER_HIGHEST_PORT"
  sed -i "s|MEDIASERVER_HIGHEST_PORT=.*|MEDIASERVER_HIGHEST_PORT='${MEDIASERVER_HIGHEST_PORT}'|" $BASEDIR/bin/restcomm/restcomm.conf
else
  MEDIASERVER_HIGHEST_PORT='65535'
  echo "MEDIASERVER_HIGHEST_PORT $MEDIASERVER_HIGHEST_PORT"
  sed -i "s|MEDIASERVER_HIGHEST_PORT=.*|MEDIASERVER_HIGHEST_PORT='${MEDIASERVER_HIGHEST_PORT}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$MEDIASERVER_EXTERNAL_ADDRESS" ]; then
   echo "MEDIASERVER_EXTERNAL_ADDRESS $MEDIASERVER_EXTERNAL_ADDRESS"
   sed -i "s|MEDIASERVER_EXTERNAL_ADDRESS=.*|MEDIASERVER_EXTERNAL_ADDRESS='${MEDIASERVER_EXTERNAL_ADDRESS}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

#MGCP ports
if [ -n "$LOCALMGCP" ]; then
   echo "LOCALMGCP $LOCALMGCP"
   sed -i "s|LOCALMGCP=.*|LOCALMGCP='${LOCALMGCP}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$REMOTEMGCP" ]; then
   echo "REMOTEMGCP $REMOTEMGCP"
   sed -i "s|REMOTEMGCP=.*|REMOTEMGCP='${REMOTEMGCP}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$RECORDINGS_PATH" ]; then
   echo "RECORDINGS_PATH $RECORDINGS_PATH"
   sed -i "s|RECORDINGS_PATH=.*|RECORDINGS_PATH='${RECORDINGS_PATH}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$OUTBOUND_PROXY" ]; then
  echo "OUTBOUND_PROXY $OUTBOUND_PROXY"
  sed -i "s|OUTBOUND_PROXY=.*|OUTBOUND_PROXY='${OUTBOUND_PROXY}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

# Address for outbound calls
if [ -n "$OUTBOUND_PROXY_USERNAME" ]; then
  echo "OUTBOUND_PROXY_USERNAME $OUTBOUND_PROXY_USERNAME"
  sed -i "s|OUTBOUND_PROXY_USERNAME=.*|OUTBOUND_PROXY_USERNAME='${OUTBOUND_PROXY_USERNAME}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$OUTBOUND_PROXY_PASSWORD" ]; then
  echo "OUTBOUND_PROXY_PASSWORD $OUTBOUND_PROXY_PASSWORD"
  sed -i "s|OUTBOUND_PROXY_PASSWORD=.*|OUTBOUND_PROXY_PASSWORD='${OUTBOUND_PROXY_PASSWORD}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

# Outbound proxy for SMS
if [ -n "$SMS_PREFIX" ]; then
  echo "SMS_PREFIX $SMS_PREFIX"
  sed -i "s|SMS_PREFIX=.*|SMS_PREFIX='${SMS_PREFIX}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$SMS_OUTBOUND_PROXY" ]; then
  echo "SMS_OUTBOUND_PROXY:  $SMS_OUTBOUND_PROXY"
  sed -i "s|SMS_OUTBOUND_PROXY=.*|SMS_OUTBOUND_PROXY='${SMS_OUTBOUND_PROXY}|"  $BASEDIR/bin/restcomm/restcomm.conf
fi

if [  "${USESBC^^}" = "FALSE"  ]; then
  sed -i 's|<property name="useSbc">true</property>|<property name="useSbc">false</property>|' $BASEDIR/bin/restcomm/autoconfig.d/config-mobicents-ms.sh
fi

if [  -n "$DTMFDBI" ]; then
  sed -i "s|<property name=\"dtmfDetectorDbi\">0</property>|<property name=\"dtmfDetectorDbi\">${DTMFDBI}</property>|" $BASEDIR/bin/restcomm/autoconfig.d/config-mobicents-ms.sh
fi

if [ -n "$RESTCOMM_LOGS" ]; then
  echo "RESTCOMM_LOGS $RESTCOMM_LOGS"
  sed -i "s|BASEDIR=.*| |" $BASEDIR/bin/restcomm/logs_collect.sh
  sed -i "s|./jvmtop.sh|${BASEDIR}/bin/restcomm/jvmtop.sh|" $BASEDIR/bin/restcomm/logs_collect.sh
  sed -i "s|LOGS_DIR_ZIP=.*|LOGS_DIR_ZIP=$RESTCOMM_LOGS/\$DIR_NAME|" $BASEDIR/bin/restcomm/logs_collect.sh
  sed -i "s|RESTCOMM_LOG_BASE=.*|RESTCOMM_LOG_BASE=${RESTCOMM_LOGS}|" /opt/embed/restcomm_docker.sh

  LOGS_LOCATE=`echo $RESTCOMM_LOGS`
  sudo mkdir -p "$LOGS_LOCATE"
  RESTCOMM_CORE_LOG=$LOGS_LOCATE
  MMS_LOGS=$LOGS_LOCATE
  LOGS_TRACE=$LOGS_LOCATE
fi

if [ -n "$PROVISION_PROVIDER" ]; then
  echo "PROVISION_PROVIDER $PROVISION_PROVIDER"
  sed -i "s|PROVISION_PROVIDER=.*|PROVISION_PROVIDER='${PROVISION_PROVIDER}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_LOGIN" ]; then
  echo "DID_LOGIN $DID_LOGIN"
  sed -i "s|DID_LOGIN=.*|DID_LOGIN='${DID_LOGIN}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_PASSWORD" ]; then
  echo "DID_PASSWORD $DID_PASSWORD"
  sed -i "s|DID_PASSWORD=.*|DID_PASSWORD='${DID_PASSWORD}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$SMPP_ACTIVATE" ]; then
  echo "Generic SMPP type $GENERIC_SMPP_TYPE"
  sed -i "s|SMPP_ACTIVATE=.*|SMPP_ACTIVATE='true'|" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SMPP_SYSTEM_ID=.*|SMPP_SYSTEM_ID='${GENERIC_SMPP_ID}'|" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SMPP_PASSWORD=.*|SMPP_PASSWORD='${GENERIC_SMPP_PASSWORD}'|" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SMPP_SYSTEM_TYPE=.*|SMPP_SYSTEM_TYPE='${GENERIC_SMPP_TYPE}'" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SMPP_PEER_IP=.*|SMPP_PEER_IP='${GENERIC_SMPP_PEER_IP}'" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SMPP_PEER_PORT=.*|SMPP_PEER_PORT='${GENERIC_SMPP_PEER_PORT}'" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|<connection activateAddressMapping=\"false\" sourceAddressMap=\"\" destinationAddressMap=\"\" tonNpiValue=\"1\">|<connection activateAddressMapping=\"false\" sourceAddressMap=\"${GENERIC_SMPP_SOURCE_MAP}\" destinationAddressMap=\"${GENERIC_SMPP_DEST_MAP}\" tonNpiValue=\"1\">|" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml
fi

if [ -n "$NEXMO_SMPP_TYPE" ]; then
  echo "NEXMO_SMPP_TYPE $NEXMO_SMPP_TYPE"
  sed -i "s|SMPP_ACTIVATE=.*|SMPP_ACTIVATE='true'|" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SMPP_SYSTEM_ID=.*|SMPP_SYSTEM_ID='${DID_LOGIN}'|" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SMPP_PASSWORD=.*|SMPP_PASSWORD='${DID_PASSWORD}'|" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SMPP_SYSTEM_TYPE=.*|SMPP_SYSTEM_TYPE='${NEXMO_SMPP_TYPE}'|" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SMPP_PEER_IP=.*|SMPP_PEER_IP='smpp0.nexmo.com'|" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SMPP_PEER_PORT=.*|SMPP_PEER_PORT='8000'|" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|<connection activateAddressMapping=\"false\" sourceAddressMap=\"\" destinationAddressMap=\"\" tonNpiValue=\"1\">|<connection activateAddressMapping=\"false\" sourceAddressMap=\"6666\" destinationAddressMap=\"7777\" tonNpiValue=\"1\">|" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml
fi

if [ -n "$DID_ENDPOINT" ]; then
  echo "DID_ENDPOINT $DID_ENDPOINT"
  sed -i "s|DID_ENDPOINT=.*|DID_ENDPOINT='${DID_ENDPOINT}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_SITEID" ]; then
  echo "DID_SITEID $DID_SITEID"
  sed -i "s|DID_SITEID=.*|DID_SITEID='${DID_SITEID}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_ACCOUNTID" ]; then
  echo "DID_ACCOUNTID $DID_ACCOUNTID"
  sed -i "s|DID_ACCOUNTID=.*|DID_ACCOUNTID='${DID_ACCOUNTID}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$INTERFAX_USER" ]; then
  echo "INTERFAX_USER $INTERFAX_USER"
  sed -i "s|INTERFAX_USER=.*|INTERFAX_USER='${INTERFAX_USER}'" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$INTERFAX_PASSWORD" ]; then
  echo "INTERFAX_PASSWORD $INTERFAX_PASSWORD"
  sed -i "s|INTERFAX_PASSWORD=.*|INTERFAX_PASSWORD='${INTERFAX_PASSWORD}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ISPEECH_KEY" ]; then
  echo "ISPEECH_KEY $ISPEECH_KEY"
  sed -i "s|ISPEECH_KEY=.*|ISPEECH_KEY='${ISPEECH_KEY}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$VOICERSS_KEY" ]; then
  echo "VoiceRSS key: $VOICERSS_KEY"
  sed -i "s|VOICERSS_KEY=.*|VOICERSS_KEY='${VOICERSS_KEY}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ACAPELA_APPLICATION" ]; then
  echo "ACAPELA_APPLICATION $ACAPELA_APPLICATION"
  sed -i "s|ACAPELA_APPLICATION=.*|ACAPELA_APPLICATION='${ACAPELA_APPLICATION}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ACAPELA_LOGIN" ]; then
  echo "ACAPELA_LOGIN $ACAPELA_LOGIN"
  sed -i "s|ACAPELA_LOGIN=.*|ACAPELA_LOGIN='${ACAPELA_LOGIN}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ACAPELA_PASSWORD" ]; then
  echo "ACAPELA_PASSWORD $ACAPELA_PASSWORD"
  sed -i "s|ACAPELA_PASSWORD=.*|ACAPELA_PASSWORD='${ACAPELA_PASSWORD}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [  "${USE_STANDARD_HTTP_PORTS^^}" = "TRUE"  ]; then
  echo "USE_STANDARD_HTTP_PORTS  $USE_STANDARD_HTTP_PORTS "
  sed -i "s|HTTP_PORT=.*|HTTP_PORT=80|"   $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|HTTPS_PORT=.*|HTTPS_PORT=443|"   $BASEDIR/bin/restcomm/restcomm.conf
fi

if [  "${USE_STANDARD_SIP_PORTS^^}" = "TRUE"  ]; then
  echo "USE_STANDARD_SIP_PORTS $USE_STANDARD_SIP_PORTS"
  sed -i "s|SIP_PORT_UDP=.*|SIP_PORT_UDP=5060|"   $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SIP_PORT_TCP=.*|SIP_PORT_TCP=5060|"   $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SIP_PORT_TLS=.*|SIP_PORT_TLS=5061|"   $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SIP_PORT_WS=.*|SIP_PORT_WS=5062|"     $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s|SIP_PORT_WSS=.*|SIP_PORT_WSS=5063|"   $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$PORT_OFFSET" ]; then
    echo "PORT_OFFSET $PORT_OFFSET"
    sed -i "s|PORT_OFFSET=.*|PORT_OFFSET=${PORT_OFFSET}|"   $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$PLAY_WAIT_MUSIC" ]; then
    echo "PLAY_WAIT_MUSIC $PLAY_WAIT_MUSIC"
    sed -i "s|PLAY_WAIT_MUSIC=.*|PLAY_WAIT_MUSIC=${PLAY_WAIT_MUSIC}|"   $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$S3_BUCKET_NAME" ]; then
  echo "S3_BUCKET_NAME $S3_BUCKET_NAME S3_ACCESS_KEY $S3_ACCESS_KEY S3_SECURITY_KEY $S3_SECURITY_KEY"
  sed -i "/<amazon-s3>/ {
		N; s|<enabled>.*</enabled>|<enabled>true</enabled>|
		N; s|<bucket-name>.*</bucket-name>|<bucket-name>${S3_BUCKET_NAME}</bucket-name>|
		N; s|<folder>.*</folder>|<folder>logs</folder>|
		N; s|<access-key>.*</access-key>|<access-key>${S3_ACCESS_KEY}</access-key>|
		N; s|<security-key>.*</security-key>|<security-key>${S3_SECURITY_KEY}</security-key>|
	}" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml
fi

if [ -n "$S3_BUCKET_REGION" ]; then
  echo "S3_BUCKET_REGION $S3_BUCKET_REGION"
  sed -i "s|<bucket-region>.*</bucket-region>|<bucket-region>${S3_BUCKET_REGION}</bucket-region>|" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml
fi

if [ -n "$INIT_PASSWORD" ]; then
    # chnange admin password
    SQL_FILE=$BASEDIR/standalone/deployments/restcomm.war/WEB-INF/data/hsql/restcomm.script
    PASSWORD_ENCRYPTED=`echo -n "${INIT_PASSWORD}" | md5sum |cut -d " " -f1`
    echo "Update password to ${INIT_PASSWORD}($PASSWORD_ENCRYPTED)"
    sed -i "s/uninitialized/active/g" $SQL_FILE
    sed -i "s/77f8c12cc7b8f8423e5c38b035249166/$PASSWORD_ENCRYPTED/g" $SQL_FILE
    sed -i "s/2012-04-24 00:00:00.000000000/2016-02-17 10:00:00.575000000/" $SQL_FILE
    sed -i "s/2012-04-24 00:00:00.000000000/2016-02-17 10:04:00.575000000/" $SQL_FILE

    SQL_FILE=$BASEDIR/standalone/deployments/restcomm.war/WEB-INF/scripts/mariadb/init.sql
    sed -i "s/uninitialized/active/g" $SQL_FILE
    sed -i "s/77f8c12cc7b8f8423e5c38b035249166/$PASSWORD_ENCRYPTED/g" $SQL_FILE
    sed -i 's/Date("2012-04-24")/now()/' $SQL_FILE
    sed -i 's/Date("2012-04-24")/now()/' $SQL_FILE

    # end
fi

if [ -n "$HSQL_PERSIST" ]; then
  echo "HSQL_PERSIST $HSQL_PERSIST"
  mkdir -p $HSQL_PERSIST
  sed -i "s|<data-files>.*</data-files>|<data-files>${HSQL_PERSIST}</data-files>|"  $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml
  cp $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/data/hsql/* $HSQL_PERSIST
fi

if [ -n "$SMTP_USER" ]; then
  echo "SMTP_USER $SMTP_USER SMTP_PASSWORD $SMTP_PASSWORD SMTP_HOST $SMTP_HOST"
  sed -i "/<smtp-notify>/ {
		N; s|<host>.*</host>|<host>${SMTP_HOST}</host>|
		N; s|<user>.*</user>|<user>${SMTP_USER}</user>|
		N; s|<password>.*</password>|<password>${SMTP_PASSWORD}</password>|
	}" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml

  sed -i "/<smtp-service>/ {
		N; s|<host>.*</host>|<host>${SMTP_HOST}</host>|
		N; s|<user>.*</user>|<user>${SMTP_USER}</user>|
		N; s|<password>.*</password>|<password>${SMTP_PASSWORD}</password>|
	}" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/conf/restcomm.xml
fi

if [ -n "$MYSQL_USER" ]; then
  echo "MYSQL_USER $MYSQL_USER MYSQL_HOST $MYSQL_HOST MYSQL_SCHEMA $MYSQL_SCHEMA"
  grep -q 'MYSQL_HOST=' $BASEDIR/bin/restcomm/restcomm.conf || echo "MYSQL_HOST='${MYSQL_HOST}'" >> $BASEDIR/bin/restcomm/restcomm.conf
  grep -q 'MYSQL_USER=' $BASEDIR/bin/restcomm/restcomm.conf ||  echo "MYSQL_USER='${MYSQL_USER}'" >> $BASEDIR/bin/restcomm/restcomm.conf
  grep -q 'MYSQL_PASSWORD=' $BASEDIR/bin/restcomm/restcomm.conf ||  echo "MYSQL_PASSWORD='${MYSQL_PASSWORD}'" >> $BASEDIR/bin/restcomm/restcomm.conf

 if [ -n "$MYSQL_SNDHOST" ]; then
     echo "MYSQL_SNDHOST=${MYSQL_SNDHOST}" >> $BASEDIR/bin/restcomm/restcomm.conf
 fi

  if [ -n "$MYSQL_SCHEMA" ]; then
	grep -q 'MYSQL_SCHEMA=' $BASEDIR/bin/restcomm/restcomm.conf || echo "MYSQL_SCHEMA='${MYSQL_SCHEMA}'" >> $BASEDIR/bin/restcomm/restcomm.conf
  else
	$MYSQL_SCHEMA="restcomm"
	  grep -q 'MYSQL_SCHEMA=' $BASEDIR/bin/restcomm/restcomm.conf || echo "MYSQL_SCHEMA='${MYSQL_SCHEMA}'" >> $BASEDIR/bin/restcomm/restcomm.conf
  fi

  echo "MYSQL_USER $MYSQL_USER MYSQL_HOST $MYSQL_HOST MYSQL_SCHEMA $MYSQL_SCHEMA"
  sed -i "s|restcomm;|${MYSQL_SCHEMA};|" $BASEDIR/standalone/deployments/restcomm.war/WEB-INF/scripts/mariadb/init.sql
  source $BASEDIR/bin/restcomm/populate-update-mysqldb.sh $MYSQL_HOST $MYSQL_USER $MYSQL_PASSWORD $MYSQL_SCHEMA
fi

if [ -n "$SSL_MODE" ]; then
	sed -i "s|SSL_MODE=.*|SSL_MODE='${SSL_MODE}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$RVD_LOCATION" ]; then
  echo "RVD_LOCATION $RVD_LOCATION"
  mkdir -p `echo $RVD_LOCATION`
  sed -i "s|<workspaceLocation>.*</workspaceLocation>|<workspaceLocation>${RVD_LOCATION}</workspaceLocation>|" $BASEDIR/standalone/deployments/restcomm-rvd.war/WEB-INF/rvd.xml

  COPYFLAG=$RVD_LOCATION/.demos_initialized
  if [ -f "$COPYFLAG" ];
  then
   #Do nothing, we already copied the demo file to the new workspace
    echo "RVD demo application are already copied"
  else
    echo "Will copy RVD demo applications to the new workspace $RVD_LOCATION"
    cp -ar $BASEDIR/standalone/deployments/restcomm-rvd.war/workspace/* $RVD_LOCATION
    touch $COPYFLAG
  fi

fi

#Patch provided for the RVD backup Directory for the migration process (in order to save the backup at the host need to  mount this directory e.g. -v host_path:RVD_MIGRATION_BACKUP).
if [ -n "$RVD_MIGRATION_BACKUP" ]; then
    echo "RVD_MIGRATION_BACKUP $RVD_MIGRATION_BACKUP"
    sed -i "s|<workspaceBackupLocation>.*</workspaceBackupLocation>|<workspaceBackupLocation>${RVD_MIGRATION_BACKUP}</workspaceBackupLocation>|" $BASEDIR/standalone/deployments/restcomm-rvd.war/WEB-INF/rvd.xml
fi

if [ -n "$LOG_LEVEL" ]; then
  echo "LOG_LEVEL $LOG_LEVEL"
  sed -i "s|<logger category=\"org.mobicents.servlet.sip\">|<logger category=\"org.mobicents.servlet\">|" $BASEDIR/standalone/configuration/standalone-sip.xml
  sed -i "/<logger category=\"org.mobicents.servlet\">/ {
		N; s|<level name=\".*\"/>|<level name=\"${LOG_LEVEL}\"/>|
	}" $BASEDIR/standalone/configuration/standalone-sip.xml
    sed -i  "s|<param name=\"Threshold\" value=\"INFO\" />|<param name=\"Threshold\" value=\"${LOG_LEVEL}\" />|"  $BASEDIR/mediaserver/conf/log4j.xml
    sed -i  "s|<priority value=\"INFO\"/>|<priority value=\"${LOG_LEVEL}\"/>|"  $BASEDIR/mediaserver/conf/log4j.xml
fi

if [ -n "$CORE_LOGS_LOCATION" ]; then
  echo "CORE_LOGS_LOCATION $CORE_LOGS_LOCATION"
  mkdir -p `echo $CORE_LOGS_LOCATION`
  sed -i "s|find .*server.log|find $RESTCOMM_CORE_LOG/${CORE_LOGS_LOCATION}/restcommCore-server.log*|" /etc/cron.d/restcommcore-cron
  sed -i "s|<file relative-to=\"jboss.server.log.dir\" path=\".*\"\/>|<file path=\"$RESTCOMM_CORE_LOG/${CORE_LOGS_LOCATION}/restcommCore-server.log\"\/>|" $BASEDIR/standalone/configuration/standalone-sip.xml
  #logs collect script conficuration
  sed -i "s/RESTCOMM_CORE_FILE=server.log/RESTCOMM_CORE_FILE=restcommCore-server.log/" /opt/Restcomm-JBoss-AS7/bin/restcomm/logs_collect.sh
  sed -i "s|RESTCOMM_CORE_LOG=.*|RESTCOMM_CORE_LOG=$RESTCOMM_CORE_LOG/${CORE_LOGS_LOCATION}|" /opt/Restcomm-JBoss-AS7/bin/restcomm/logs_collect.sh
  sed -i "s|RESTCOMM_LOG_BASE=.*|RESTCOMM_LOG_BASE=${CORE_LOGS_LOCATION}|" /opt/Restcomm-JBoss-AS7/bin/restcomm/logs_collect.sh

fi

#Media-server Log configuration.
if [ -n "$MEDIASERVER_LOGS_LOCATION" ]; then
  echo "MEDIASERVER_LOGS_LOCATION $MEDIASERVER_LOGS_LOCATION"
  mkdir -p `echo $MEDIASERVER_LOGS_LOCATION`
  sed -i "s|find .*server.log|find $MMS_LOGS/${MEDIASERVER_LOGS_LOCATION}/media-server.log*|" /etc/cron.d/restcommmediaserver-cron
  sed -i 's/configLogDirectory$/#configLogDirectory/' $BASEDIR/bin/restcomm/autoconfig.d/config-mobicents-ms.sh
  #Daily log rotation for MS.
  sed -i "s|<appender name=\"FILE\" class=\"org\.apache\.log4j\.RollingFileAppender\"|<appender name=\"FILE\" class=\"org\.apache\.log4j\.DailyRollingFileAppender\"|"  $BASEDIR/mediaserver/conf/log4j.xml
  sed -i "s|<param name=\"Append\" value=\"false\"|<param name=\"Append\" value=\"true\"|"  $BASEDIR/mediaserver/conf/log4j.xml
  sed -i "s|<param name=\"File\" value=\".*\"|<param name=\"File\" value=\"$MMS_LOGS/${MEDIASERVER_LOGS_LOCATION}/media-server.log\"|"  $BASEDIR/mediaserver/conf/log4j.xml
  #logs collect script conficuration
  sed -i "s|MEDIASERVER_FILE=server.log|MEDIASERVER_FILE=media-server.log|" /opt/Restcomm-JBoss-AS7/bin/restcomm/logs_collect.sh
  sed -i "s|MMS_LOGS=.*|MMS_LOGS=$MMS_LOGS/${MEDIASERVER_LOGS_LOCATION}|" /opt/Restcomm-JBoss-AS7/bin/restcomm/logs_collect.sh
fi

if [ -n "$GOVNIST_LOG_LEVEL" ]; then
  sed -i "/<logger category=\"gov.nist\">/ {N; s/<level name=\"INFO\"\/>/<level name=\"${GOVNIST_LOG_LEVEL}\"\/>/}" $BASEDIR/standalone/configuration/standalone-sip.xml
fi

if [ -n "$RESTCOMM_TRACE_LOG" ]; then
  echo "RESTCOMM_TRACE_LOG $RESTCOMM_TRACE_LOG"
  mkdir -p $LOGS_TRACE/$RESTCOMM_TRACE_LOG
  sed -i "s|find .*restcomm_trace_|find $LOGS_TRACE/${RESTCOMM_TRACE_LOG}/restcomm_trace_|" /etc/cron.d/restcommtcpdump-cron
  sed -i "s|RESTCOMM_TRACE=.*|RESTCOMM_TRACE=\$RESTCOMM_LOG_BASE/${RESTCOMM_TRACE_LOG}|"  /opt/embed/restcomm_docker.sh

  sipHPort=5083
  sipLPort=5080
  mgcpL=2427
  mgcpR=2727
  http=8080
  https=8443
    if [  "${USE_STANDARD_SIP_PORTS^^}" = "TRUE"  ]; then
        sipHPort=5063
        sipLPort=5060
    fi

    if [  "${USE_STANDARD_HTTP_PORTS^^}" = "TRUE"  ]; then
        http=80
        https=443
    fi

    if [ -n "$PORT_OFFSET" ]; then
	    mgcpL=$((mgcpL + $PORT_OFFSET))
        mgcpR=$((mgcpR + $PORT_OFFSET))
        sipHPort=$((sipHPort + $PORT_OFFSET))
        sipLPort=$((sipLPort + $PORT_OFFSET))
        https=$((https + $PORT_OFFSET))
        http=$((http + $PORT_OFFSET))
    fi

    nohup xargs bash -c "tcpdump -pni any -t -n -s 0  \"portrange ${sipLPort}-${sipHPort} or (udp and portrange ${MEDIASERVER_LOWEST_PORT}-${MEDIASERVER_HIGHEST_PORT}) or port ${http} or port ${https}  or port ${mgcpL}  or port ${mgcpR} \" -G 3500 -w $LOGS_TRACE/$RESTCOMM_TRACE_LOG/restcomm_trace_%Y-%m-%d_%H:%M:%S-%Z.pcap -z gzip" &

 #Used to start TCPDUMP when restarting container
 TCPFILE="/etc/my_init.d/restcommtrace.sh"
    cat <<EOT >> $TCPFILE
#!/bin/bash
     nohup xargs bash -c "tcpdump -pni any -t -n -s 0  \"portrange $sipLPort-$sipHPort or (udp and portrange $MEDIASERVER_LOWEST_PORT-$MEDIASERVER_HIGHEST_PORT) or port $http or port $https or port $mgcpL or port $mgcpR\" -G 3500 -w $LOGS_TRACE/$RESTCOMM_TRACE_LOG/restcomm_trace_%Y-%m-%d_%H:%M:%S-%Z.pcap -z gzip" &
EOT
    chmod 777 $TCPFILE
fi

if [ "${PROD_MODE^^}" = "TRUE" ]; then
    JBOSS_CONFIG=standalone

    echo "Update RestComm log level to WARN"
    sed -i 's/INFO/WARN/g' $BASEDIR/$JBOSS_CONFIG/configuration/standalone-sip.xml
    sed -i 's/ERROR/WARN/g' $BASEDIR/$JBOSS_CONFIG/configuration/standalone-sip.xml
    sed -i 's/DEBUG/WARN/g' $BASEDIR/$JBOSS_CONFIG/configuration/standalone-sip.xml

    echo "Update MMS log level to WARN"
    sed -i 's/INFO/WARN/g' $BASEDIR/mediaserver/conf/log4j.xml
    sed -i 's/ERROR/WARN/g' $BASEDIR/mediaserver/conf/log4j.xml
    sed -i 's/DEBUG/WARN/g' $BASEDIR/mediaserver/conf/log4j.xml

    echo "Update AKKA log level to OFF"
    sed -i 's/INFO/OFF/g' $BASEDIR/$JBOSS_CONFIG/deployments/restcomm.war/WEB-INF/classes/application.conf
fi

if [ -n "$RC_JAVA_OPTS" ]; then
    echo "RestComm java options: $RC_JAVA_OPTS"
    sed -i "s|RC_JAVA_OPTS=.*|RC_JAVA_OPTS='${RC_JAVA_OPTS}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$RMS_JAVA_OPTS" ]; then
    echo "mediasercer java options: $RMS_JAVA_OPTS"
    sed -i "s|RMS_JAVA_OPTS=.*|RMS_JAVA_OPTS='${RMS_JAVA_OPTS}'|" $BASEDIR/bin/restcomm/restcomm.conf
fi

##Additional SIP connector if set
grep "ADDITIONAL_CONNECTOR_" /etc/container_environment.sh | cut -d " " -f2 |while read line; do  echo $line >> $BASEDIR/bin/restcomm/advanced.conf;   done
#auto delete script after run once. No need more.
rm -- "$0"
