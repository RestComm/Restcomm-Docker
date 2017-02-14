#!/usr/bin/env bash

source /etc/container_environment.sh

BASEDIR=/opt/Restcomm-JBoss-AS7

chmod +x $BASEDIR/bin/*.sh
chmod +x $BASEDIR/bin/restcomm/*.sh
chmod +x $BASEDIR/bin/restcomm/monitoring/*.sh
chmod +x /opt/embed/*.sh
mkdir -p "${RESTCOMM_LOGS}"/opt/
cp /tmp/version "${RESTCOMM_LOGS}"
cp /opt/embed/dockercleanup.sh  "${RESTCOMM_LOGS}"/opt/
cp /opt/embed/restcomm_docker.sh  "${RESTCOMM_LOGS}"/opt/

# Ensure cron is allowed to run"
sed -i 's/^\(session\s\+required\s\+pam_loginuid\.so.*$\)/# \1/g' /etc/pam.d/cron

mkdir -p /etc/service/restcomm
mv /tmp/start-restcomm.sh $BASEDIR/bin/restcomm/start-restcomm.sh
chmod +x $BASEDIR/bin/restcomm/start-restcomm.sh
mv /tmp/restcomm_service.sh /etc/service/restcomm/run
chmod +x /etc/service/restcomm/run

mkdir -p /etc/service/rms
mv /tmp/start-mediaserver.sh $BASEDIR/mediaserver/start-mediaserver.sh
chmod +x $BASEDIR/mediaserver/start-mediaserver.sh
mv /tmp/rms_service.sh /etc/service/rms/run
chmod +x /etc/service/rms/run

echo "RestComm configured Properly!"

#Olympus x2
mv /tmp/config-olympus.sh $BASEDIR/bin/restcomm/autoconfig.d/config-olympus.sh

#auto delete script after run once. No need more.
rm -- "$0"