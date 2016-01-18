#!/bin/bash
#Default ENV vars
#LOGS
echo -e "/var/log/restcomm/restcomm_core" > /etc/container_environment/CORE_LOGS_LOCATION
echo -e "/var/log/restcomm/restcomm_trace" > /etc/container_environment/RESTCOMM_TRACE_LOG
echo -e "/var/log/restcomm/media_server" > /etc/container_environment/MEDIASERVER_LOGS_LOCATION

#SSL certificate
echo -e "SELF" > /etc/container_environment/SECURESSL
echo -e "allowall" > /etc/container_environment/SSL_MODE


#Functional configuration.
echo -e "true" > /etc/container_environment/USE_STANDARD_PORTS

#Log
echo -e "INFO" > /etc/container_environment/LOG_LEVEL

#RVD_LOCATION
echo -e "/opt/rvd/workspace/" > /etc/container_environment/RVD_LOCATION

#TTS
echo -e "d80d266a1a7f46edac6b1a17ad797b63" > /etc/container_environment/VOICERSS_KEY
#SMS
echo -e "''" > /etc/container_environment/SMS_PREFIX

#IP
echo -e "PUT__IP" > /etc/container_environment/STATIC_ADDRESS

#cerificate
echo -e "URL_FOR_CERTIFICATE" > /etc/container_environment/CERTCONFURL
echo -e "USER_FOR_AUTH" > /etc/container_environment/CERTREPOUSR
echo -e "PASSWD_FOR_AUTH" > /etc/container_environment/CERTREPOPWRD

echo -e "URL_FOR_ENV_FILE" > /etc/container_environment/DERCONFURL
echo -e "USER" > /etc/container_environment/DERREPOUSR
echo -e "PASSED" > /etc/container_environment/DERREPOPWRD