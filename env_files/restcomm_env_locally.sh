#!/bin/bash
#Default ENV vars for Amazon AMI
#LOGS

echo -e "/var/log/restcomm" > /etc/container_environment/EXTCONF_RESTCOMM_LOGS

echo -e "restcomm_core" > /etc/container_environment/EXTCONF_CORE_LOGS_LOCATION
echo -e "restcomm_trace" > /etc/container_environment/EXTCONF_RESTCOMM_TRACE_LOG
echo -e "media_server" > /etc/container_environment/EXTCONF_MEDIASERVER_LOGS_LOCATION

#SSL certificate
echo -e "SELF" > /etc/container_environment/RCADVCONF_SECURESSL
echo -e "allowall" > /etc/container_environment/RCADVCONF_SSL_MODE
echo -e "changeme" > /etc/container_environment/RCADVCONF_TRUSTSTORE_PASSWORD
echo -e "restcomm" > /etc/container_environment/RCADVCONF_TRUSTSTORE_ALIAS

#RestComm Port configuration
echo -e "5080" > /etc/container_environment/RCBCONF_SIP_PORT_UDP
echo -e "5080" > /etc/container_environment/RCBCONF_SIP_PORT_TCP
echo -e "5081" > /etc/container_environment/RCBCONF_SIP_PORT_TLS
echo -e "5082" > /etc/container_environment/RCBCONF_SIP_PORT_WS
echo -e "5083" > /etc/container_environment/RCBCONF_SIP_PORT_WSS

#Functional configuration.
echo -e "55500" > /etc/container_environment/RMSCONF_MEDIA_LOW_PORT
echo -e "65500" > /etc/container_environment/RMSCONF_MEDIA_HIGH_PORT

#Log
echo -e "INFO" > /etc/container_environment/RCBCONF_LOG_LEVEL
echo -e "INFO" > /etc/container_environment/RCBCONF_AKKA_LOG_LEVEL
echo -e "INFO" > /etc/container_environment/RCBCONF_LOG_LEVEL_COMPONENT_GOVNIST
echo -e "INFO" > /etc/container_environment/RCBCONF_LOG_LEVEL_COMPONENT_SIPSERVLET
echo -e "INFO" > /etc/container_environment/RCBCONF_LOG_LEVEL_COMPONENT_SIPRESTCOMM
echo -e "INFO" > /etc/container_environment/RCBCONF_LOG_LEVEL_COMPONENT_RESTCOMM

#SMS
echo -e "''" > /etc/container_environment/SMS_PREFIX

#TTS - this is a free acount KEY - please create your personal key (http://www.voicerss.org/)
echo -e "f4840af6675b4d20a8d96dea8466296b" > /etc/container_environment/RCBCONF_VOICERSS_KEY

#RVD_LOCATION
echo -e "/var/restcomm/rvd/workspace" > /etc/container_environment/RCADVCONF_RVD_LOCATION

#HSQL-persist data - Need to mount this path on the host. else data is not persistent.
echo -e "/var/restcomm/data" > /etc/container_environment/RCADVCONF_HSQL_DIR
