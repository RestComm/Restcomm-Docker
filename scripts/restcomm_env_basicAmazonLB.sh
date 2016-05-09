#!/bin/bash
#Default ENV vars for Amazon AMI
#LOGS

echo -e "/var/log/restcomm" > /etc/container_environment/RESTCOMM_LOGS

echo -e "restcomm_core" > /etc/container_environment/CORE_LOGS_LOCATION
echo -e "restcomm_trace" > /etc/container_environment/RESTCOMM_TRACE_LOG
echo -e "media_server" > /etc/container_environment/MEDIASERVER_LOGS_LOCATION

#SSL certificate
echo -e "SELF" > /etc/container_environment/SECURESSL
echo -e "allowall" > /etc/container_environment/SSL_MODE
echo -e "changeme" > /etc/container_environment/TRUSTSTORE_PASSWORD
echo -e "restcomm" > /etc/container_environment/TRUSTSTORE_ALIAS


#Functional configuration.
echo -e "TRUE" > /etc/container_environment/USE_STANDARD_HTTP_PORTS
echo -e "TRUE" > /etc/container_environment/USE_STANDARD_SIP_PORTS
echo -e "65000" > /etc/container_environment/MEDIASERVER_LOWEST_PORT
echo -e "65050" > /etc/container_environment/MEDIASERVER_HIGHEST_PORT


#Log
echo -e "DEBUG" > /etc/container_environment/LOG_LEVEL

#SMS
echo -e "''" > /etc/container_environment/SMS_PREFIX

#IP
echo -e "`curl http://instance-data/latest/meta-data/public-ipv4`" > /etc/container_environment/STATIC_ADDRESS
#echo -e "174.129.212.36" > /etc/container_environment/STATIC_ADDRESS
#echo -e "127.0.0.1" > /etc/container_environment/STATIC_ADDRESS

#TTS - this is a free acount KEY - please create your personal key (http://www.voicerss.org/)
echo -e "f4840af6675b4d20a8d96dea8466296b" > /etc/container_environment/VOICERSS_KEY

#RVD_LOCATION
echo -e "/var/restcomm/rvd/workspace" > /etc/container_environment/RVD_LOCATION

#HSQL-persist data - Need to mount this path on the host. else data is not persistent.
echo -e "/var/restcomm/data" > /etc/container_environment/HSQL_PERSIST


echo -e "TRUE" > /etc/container_environment/ACTIVATE_LB
echo -e "10.61.221.110" > /etc/container_environment/LB_ADDRESS
echo -e "5082" > /etc/container_environment/LB_INTERNAL_PORT
echo -e "5080" > /etc/container_environment/LB_SIP_PORT_UDP
echo -e "5080" > /etc/container_environment/LB_SIP_PORT_TCP
echo -e "5081" > /etc/container_environment/LB_SIP_PORT_TLS
echo -e "5082" > /etc/container_environment/LB_SIP_PORT_WS
echo -e "5083" > /etc/container_environment/LB_SIP_PORT_WSS
