#!/bin/bash
#Default ENV vars
#LOGS

echo -e "/var/log/restcomm" > /etc/container_environment/EXTCONF_RESTCOMM_LOGS
echo -e "restcomm_core" > /etc/container_environment/EXTCONF_CORE_LOGS_LOCATION
echo -e "restcomm_trace" > /etc/container_environment/EXTCONF_RESTCOMM_TRACE_LOG
echo -e "media_server" > /etc/container_environment/EXTCONF_MEDIASERVER_LOGS_LOCATION

#Configurable - need to set for each server.
#server dependent
echo -e "PUT_HOSTNAME" > /etc/container_environment/RESTCOMMHOST

#IP
echo -e "PUT__IP" > /etc/container_environment/RCBCONF_STATIC_ADDRESS

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

#Persistent Data(If need to persist date, else data will be lost everytime container is deleted)
#MYSQL
echo -e "Put_Your_User" > /etc/container_environment/EXTCONF_MYSQL_USER
echo -e "Put_Your_Password" > /etc/container_environment/EXTCONF_MYSQL_PASSWORD
echo -e "MYSQL_HOST" > /etc/container_environment/EXTCONF_MYSQL_HOST
echo -e "MYSQL_DB" > /etc/container_environment/EXTCONF_MYSQL_SCHEMA

#SMTP
echo -e "YOUR_SMTP_USER" > /etc/container_environment/RCADVCONF_SMTP_USER
echo -e "SMTP_USER_PASSWD" > /etc/container_environment/RCADVCONF_SMTP_PASSWORD
echo -e "SMTP_HOST" > /etc/container_environment/RCADVCONF_SMTP_HOST


#Outbound - PSTN DID.
echo -e "PUT_OUTBOUND_PROXY" > /etc/container_environment/RCBCONF_OUTBOUND_PROXY
echo -e "OUTBOUND_PROXY_USER" > /etc/container_environment/RCBCONF_OUTBOUND_PROXY_USERNAME
echo -e "OUTBOUND_PROXY_PASSWD" > /etc/container_environment/RCBCONF_OUTBOUND_PROXY_PASSWORD
echo -e "PROVISION_PROVIDER" > /etc/container_environment/RCBCONF_PROVISION_PROVIDER
echo -e "DID_LOGIN" > /etc/container_environment/RCBCONF_DID_LOGIN
echo -e "DID_PASSWORD" > /etc/container_environment/RCBCONF_DID_PASSWORD

#SMPP
echo -e "GENERIC_SMPP_TYPE" > /etc/container_environment/RCBCONF_SMPP_ACTIVATE
echo -e "GENERIC_SMPP_TYPE" > /etc/container_environment/RCBCONF_SMPP_ACTIVATE
echo -e "GENERIC_SMPP_ID" > /etc/container_environment/GENERIC_SMPP_ID
echo -e "GENERIC_SMPP_PASSWD" > /etc/container_environment/GENERIC_SMPP_PASSWORD
echo -e "GENERIC_SMPP_IP" > /etc/container_environment/GENERIC_SMPP_PEER_IP
echo -e "GENERIC_SMPP_PORT" > /etc/container_environment/GENERIC_SMPP_PEER_PORT
echo -e "GENERIC_SMPP_SOURCE_MAP" > /etc/container_environment/GENERIC_SMPP_SOURCE_MAP
echo -e "GENERIC_SMPP_DEST_MAP" > /etc/container_environment/GENERIC_SMPP_DEST_MAP

#TTS
echo -e "KEY_FOR_TTS" > /etc/container_environment/RCBCONF_VOICERSS_KEY
#SMS
echo -e "''" > /etc/container_environment/SMS_PREFIX

#cerificate (If secure=AUTH)
echo -e "URL_FOR_CERTIFICATE" > /etc/container_environment/CERTCONFURL
echo -e "USER_FOR_AUTH" > /etc/container_environment/CERTREPOUSR
echo -e "PASSWD_FOR_AUTH" > /etc/container_environment/CERTREPOPWRD