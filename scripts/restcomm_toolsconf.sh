#!/usr/bin/env bash

source /etc/container_environment.sh

BASEDIR=/opt/Restcomm-JBoss-AS7

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