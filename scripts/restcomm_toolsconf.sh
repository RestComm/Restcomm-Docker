#!/usr/bin/env bash

source /etc/container_environment.sh

BASEDIR=/opt/Restcomm-JBoss-AS7

mkdir $BASEDIR/standalone/deployments/olympus-exploded.war
unzip $BASEDIR/standalone/deployments/olympus.war -d $BASEDIR/standalone/deployments/olympus-exploded.war/
rm -f $BASEDIR/standalone/deployments/olympus.war
mv -f $BASEDIR/standalone/deployments/olympus-exploded.war $BASEDIR/standalone/deployments/olympus.war

if [ -n "$SECURESSL" ]; then
  sed -i "s|ws:|wss:|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
  sed -i "s|5082|5083|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
fi

if [ -n "$USE_STANDARD_PORTS" ]; then
  sed -i "s|5082|5062|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
  sed -i "s|5083|5063|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
fi

grep -q 'gather-statistics' $BASEDIR/standalone/configuration/standalone-sip.xml || sed -i "s|congestion-control-interval=\".*\"|& gather-statistics=\"true\"|" $BASEDIR/standalone/configuration/standalone-sip.xml

sed -i "s|#gov.nist.javax.sip.SIP_MESSAGE_VALVE=org.mobicents.ext.javax.sip.congestion.CongestionControlMessageValve|gov.nist.javax.sip.SIP_MESSAGE_VALVE=org.mobicents.ext.javax.sip.congestion.CongestionControlMessageValve|" $BASEDIR/standalone/configuration/mss-sip-stack.properties
sed -i "s|#org.mobicents.ext.javax.sip.congestion.CONGESTION_CONTROL_MONITOR_INTERVAL=.*|org.mobicents.ext.javax.sip.congestion.CONGESTION_CONTROL_MONITOR_INTERVAL=-1|" $BASEDIR/standalone/configuration/mss-sip-stack.properties
grep -q 'org.mobicents.ext.javax.sip.congestion.SIP_SCANNERS.*' $BASEDIR/standalone/configuration/mss-sip-stack.properties || sed -i '/gov.nist.javax.sip.SIP_MESSAGE_VALVE.*/ a \
\org.mobicents.ext.javax.sip.congestion.SIP_SCANNERS=sipvicious,sipcli,friendly-scanner,VaxSIPUserAgent
' $BASEDIR/standalone/configuration/mss-sip-stack.properties

grep -q 'jboss.bind.address.management' $BASEDIR/bin/restcomm/start-restcomm.sh || sed -i "s|RESTCOMM_HOME/bin/standalone.sh -b .*|RESTCOMM_HOME/bin/standalone.sh -b \$bind_address -Djboss.bind.address.management=\$bind_address|" $BASEDIR/bin/restcomm/start-restcomm.sh


wget --auth-no-challenge -qc https://raw.githubusercontent.com/RestComm/RestComm/0dfe74423b2099a87a54ebc576b6568c596016fd/restcomm/configuration/mms-server-beans.xml -P $BASEDIR
wget --auth-no-challenge -qc https://raw.githubusercontent.com/RestComm/RestComm/0dfe74423b2099a87a54ebc576b6568c596016fd/restcomm/configuration/config-scripts/as7-config-scripts/restcomm/autoconfig.d/dont-config-mobicents-ms.sh -P $BASEDIR
cp -rf $BASEDIR/mms-server-beans.xml $BASEDIR/mediaserver/deploy/server-beans.xml
#need to add to remove media server log reconfigure (at the future we remove this file)
sed -i 's/configLogDirectory$/#configLogDirectory/' $BASEDIR/dont-config-mobicents-ms.sh
cp -rf $BASEDIR/dont-config-mobicents-ms.sh $BASEDIR/bin/restcomm/autoconfig.d/dont-config-mobicents-ms.sh


chmod +x $BASEDIR/bin/*.sh
chmod +x $BASEDIR/bin/restcomm/*.sh
chmod +x /opt/embed/*.sh
mkdir -p /var/log/restcomm/opt/
cp /opt/embed/restcomm_docker.sh  /var/log/restcomm/opt/

echo "RestComm configured Properly!"