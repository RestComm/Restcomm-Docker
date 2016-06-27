#!/usr/bin/env bash

source /etc/container_environment.sh

BASEDIR=/opt/Restcomm-JBoss-AS7


if [ -n "$GRAYLOG_SERVER" ]; then
   echo "GRAYLOG_SERVER $GRAYLOG_SERVER"
   sed -i "s|GRAYLOG_SERVER=.*|GRAYLOG_SERVER='${GRAYLOG_SERVER}'|" $BASEDIR/bin/restcomm/advanced.conf
   sed -i "s|SERVERLABEL=.*|SERVERLABEL='${SERVERLABEL}'|" $BASEDIR/bin/restcomm/advanced.conf
   sed -i "s|HD_MONITOR=.*|HD_MONITOR='${HD_MONITOR}'|" $BASEDIR/bin/restcomm/advanced.conf
   sed -i "s|RCJVM_MONITOR=.*|RCJVM_MONITOR='${RCJVM_MONITOR}'|" $BASEDIR/bin/restcomm/advanced.conf
   sed -i "s|RMSJVM_MONITOR=.*|RMSJVM_MONITOR='${RMSJVM_MONITOR}'|" $BASEDIR/bin/restcomm/advanced.conf
   sed -i "s|RAM_MONITOR=.*|RAM_MONITOR='${RAM_MONITOR}'|" $BASEDIR/bin/restcomm/advanced.conf
fi

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