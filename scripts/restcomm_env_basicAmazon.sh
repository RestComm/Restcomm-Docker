#!/usr/bin/env bash

#!/bin/bash
#Default ENV vars for Amazon AMI
#LOGS
echo -e "/var/log/restcomm/restcomm_core" > /etc/container_environment/CORE_LOGS_LOCATION
echo -e "/var/log/restcomm/restcomm_trace" > /etc/container_environment/RESTCOMM_TRACE_LOG
echo -e "/var/log/restcomm/media_server" > /etc/container_environment/MEDIASERVER_LOGS_LOCATION

#SSL certificate
echo -e "SELF" > /etc/container_environment/SECURESSL
echo -e "allowall" > /etc/container_environment/SSL_MODE
echo -e "changeme" > /etc/container_environment/TRUSTSTORE_PASSWORD
echo -e "restcomm" > /etc/container_environment/TRUSTSTORE_ALIAS


#Functional configuration.
echo -e "true" > /etc/container_environment/USE_STANDARD_PORTS

#Log
echo -e "DEBUG" > /etc/container_environment/LOG_LEVEL

#SMS
echo -e "''" > /etc/container_environment/SMS_PREFIX

#IP
echo -e "`curl http://instance-data/latest/meta-data/public-ipv4`" > /etc/container_environment/STATIC_ADDRESS

#echo -e "HOSTNAME" > /etc/container_environment/RESTCOMMHOST

#TTS
#echo -e "KEY_FOR_TTS" > /etc/container_environment/VOICERSS_KEY