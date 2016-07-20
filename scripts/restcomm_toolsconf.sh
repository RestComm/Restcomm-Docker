#!/usr/bin/env bash

source /etc/container_environment.sh

BASEDIR=/opt/Restcomm-JBoss-AS7
RVD_DEPLOY=$BASEDIR/standalone/deployments/restcomm-rvd.war


if [ -n "$GRAYLOG_SERVER" ]; then
   echo "GRAYLOG_SERVER $GRAYLOG_SERVER"
   sed -i "s|GRAYLOG_SERVER=.*|GRAYLOG_SERVER='${GRAYLOG_SERVER}'|" $BASEDIR/bin/restcomm/advanced.conf
   sed -i "s|SERVERLABEL=.*|SERVERLABEL='${SERVERLABEL}'|" $BASEDIR/bin/restcomm/advanced.conf
   sed -i "s|HD_MONITOR=.*|HD_MONITOR='${HD_MONITOR}'|" $BASEDIR/bin/restcomm/advanced.conf
   sed -i "s|RCJVM_MONITOR=.*|RCJVM_MONITOR='${RCJVM_MONITOR}'|" $BASEDIR/bin/restcomm/advanced.conf
   sed -i "s|RMSJVM_MONITOR=.*|RMSJVM_MONITOR='${RMSJVM_MONITOR}'|" $BASEDIR/bin/restcomm/advanced.conf
   sed -i "s|RAM_MONITOR=.*|RAM_MONITOR='${RAM_MONITOR}'|" $BASEDIR/bin/restcomm/advanced.conf
   #Modify the Script for Graylog to docker needs.
   sed -i "s|hdusage=.*|hdusage=\$\(df -h \| grep /dev/xvda1 \| awk -F \" \" '{print \$5}'\)|" $BASEDIR/bin/restcomm/monitoring/Graylog_Monitoring.sh
   sed -i "s|cut -d \" \" -f 1|cut -d \" \" -f 2|" $BASEDIR/bin/restcomm/monitoring/Graylog_Monitoring.sh
   sed -i "s|cut -f3,4,5,6,7,8 -d ' '|cut -f4,5,6,7,8,9 -d ' '|" $BASEDIR/bin/restcomm/monitoring/Graylog_Monitoring.sh

fi

if [ -n "$RVD_PORT" ]; then
    echo "RVD_PORT $RVD_PORI"
    if [[ "$DISABLE_HTTP" == "true" || "$DISABLE_HTTP" == "TRUE" ]]; then
        SCHEME='https'
    else
        SCHEME='http'
    fi
    #If used means that port mapping at docker (e.g: -p 445:443) is not the default (-p 443:443)
    sed -i "s|<restcommBaseUrl>.*</restcommBaseUrl>|<restcommBaseUrl>${SCHEME}://${PUBLIC_IP}:${RVD_PORT}/</restcommBaseUrl>|" $RVD_DEPLOY/WEB-INF/rvd.xml
fi

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
mv /tmp/restcomm_service.sh /etc/service/restcomm/run

echo "RestComm configured Properly!"


#auto delete script after run once. No need more.
rm -- "$0"