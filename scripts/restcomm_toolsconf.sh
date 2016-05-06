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

if [  "${USE_STANDARD_SIP_PORTS^^}" = "TRUE"  ]; then
  if [ -n "$SECURESSL" ]; then
    sed -i "s|5083|5063|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
  else
    sed -i "s|5082|5062|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
   fi
fi

if [ -n "$PORT_OFFSET" ]; then
   if [ -n "$SECURESSL" ]; then
      if [  "${USE_STANDARD_SIP_PORTS^^}" = "TRUE"  ]; then
          wss=$((5063 + $PORT_OFFSET))
          sed -i "s|5063|${wss}|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
      else
          wss=$((5083 + $PORT_OFFSET))
          sed -i "s|5083|${wss}|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
      fi
    else
       if [  "${USE_STANDARD_SIP_PORTS^^}" = "TRUE"  ]; then
          wss=$((5062 + $PORT_OFFSET))
          sed -i "s|5062|${wss}|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
      else
          wss=$((5082 + $PORT_OFFSET))
          sed -i "s|5082|${wss}|" $BASEDIR/standalone/deployments/olympus.war/resources/js/controllers/register.js
      fi
    fi

fi


grep -q 'gather-statistics' $BASEDIR/standalone/configuration/standalone-sip.xml || sed -i "s|congestion-control-interval=\".*\"|& gather-statistics=\"true\"|" $BASEDIR/standalone/configuration/standalone-sip.xml
grep -q 'jboss.bind.address.management' $BASEDIR/bin/restcomm/start-restcomm.sh || sed -i 's|RESTCOMM_HOME/bin/standalone.sh -b .*|RESTCOMM_HOME/bin/standalone.sh -b $bind_address -Djboss.bind.address.management=$bind_address|' $BASEDIR/bin/restcomm/start-restcomm.sh

chmod +x $BASEDIR/bin/*.sh
chmod +x $BASEDIR/bin/restcomm/*.sh
chmod +x /opt/embed/*.sh
mkdir -p "${RESTCOMM_LOGS}"/opt/
cp /tmp/version "${RESTCOMM_LOGS}"
cp /opt/embed/dockercleanup.sh  "${RESTCOMM_LOGS}"/opt/
cp /opt/embed/restcomm_docker.sh  "${RESTCOMM_LOGS}"/opt/

echo "RestComm configured Properly!"


#auto delete script after run once. No need more.
rm -- "$0"