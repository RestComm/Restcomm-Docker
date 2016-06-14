#!/bin/bash
#Default ENV vars
#LOGS
echo -e "/var/log/restcomm" > /etc/container_environment/RESTCOMM_LOGS
echo -e "restcomm_core" > /etc/container_environment/CORE_LOGS_LOCATION
echo -e "restcomm_trace" > /etc/container_environment/RESTCOMM_TRACE_LOG
echo -e "media_server" > /etc/container_environment/MEDIASERVER_LOGS_LOCATION

#Configurable - need to set for each server.
#server dependent
echo -e "PUT_HOSTNAME" > /etc/container_environment/RESTCOMMHOST

#IP
echo -e "PUT__IP" > /etc/container_environment/STATIC_ADDRESS

#SSL certificate
echo -e "AUTH" > /etc/container_environment/SECURESSL
echo -e "allowall" > /etc/container_environment/SSL_MODE


#Functional configuration.
echo -e "TRUE" > /etc/container_environment/USE_STANDARD_HTTP_PORTS
echo -e "TRUE" > /etc/container_environment/USE_STANDARD_SIP_PORTS
echo -e "65000" > /etc/container_environment/MEDIASERVER_LOWEST_PORT
echo -e "65050" > /etc/container_environment/MEDIASERVER_HIGHEST_PORT

#Log (DEBUG,INFO,WARN)
echo -e "INFO" > /etc/container_environment/LOG_LEVEL

#Persistent Data(If need to persist date, else data will be lost everytime container is deleted)
#MYSQL
echo -e "Put_Your_User" > /etc/container_environment/MYSQL_USER
echo -e "Put_Your_Password" > /etc/container_environment/MYSQL_PASSWORD
echo -e "MYSQL_HOST" > /etc/container_environment/MYSQL_HOST
echo -e "MYSQL_DB" > /etc/container_environment/MYSQL_SCHEMA

#SMTP
echo -e "YOUR_SMTP_USER" > /etc/container_environment/SMTP_USER
echo -e "SMTP_USER_PASSWD" > /etc/container_environment/SMTP_PASSWORD
echo -e "SMTP_HOST" > /etc/container_environment/SMTP_HOST


#Outbound - PSTN DID.
echo -e "PUT_OUTBOUND_PROXY" > /etc/container_environment/OUTBOUND_PROXY
echo -e "OUTBOUND_PROXY_USER" > /etc/container_environment/OUTBOUND_PROXY_USERNAME
echo -e "OUTBOUND_PROXY_PASSWD" > /etc/container_environment/OUTBOUND_PROXY_PASSWORD
echo -e "PROVISION_PROVIDER" > /etc/container_environment/PROVISION_PROVIDER
echo -e "DID_LOGIN" > /etc/container_environment/DID_LOGIN
echo -e "DID_PASSWORD" > /etc/container_environment/DID_PASSWORD

#SMPP
echo -e "GENERIC_SMPP_TYPE" > /etc/container_environment/GENERIC_SMPP_TYPE
echo -e "GENERIC_SMPP_ID" > /etc/container_environment/GENERIC_SMPP_ID
echo -e "GENERIC_SMPP_PASSWD" > /etc/container_environment/GENERIC_SMPP_PASSWORD
echo -e "GENERIC_SMPP_IP" > /etc/container_environment/GENERIC_SMPP_PEER_IP
echo -e "GENERIC_SMPP_PORT" > /etc/container_environment/GENERIC_SMPP_PEER_PORT
echo -e "GENERIC_SMPP_SOURCE_MAP" > /etc/container_environment/GENERIC_SMPP_SOURCE_MAP
echo -e "GENERIC_SMPP_DEST_MAP" > /etc/container_environment/GENERIC_SMPP_DEST_MAP

#TTS
echo -e "KEY_FOR_TTS" > /etc/container_environment/VOICERSS_KEY
#SMS
echo -e "''" > /etc/container_environment/SMS_PREFIX

#cerificate (If secure=AUTH)
echo -e "URL_FOR_CERTIFICATE" > /etc/container_environment/CERTCONFURL
echo -e "USER_FOR_AUTH" > /etc/container_environment/CERTREPOUSR
echo -e "PASSWD_FOR_AUTH" > /etc/container_environment/CERTREPOPWRD

#support loadbalancers
echo -e "" > /etc/container_environment/LOAD_BALANCERS



#Backwords compatibility will be removed in next release..
echo -e "TRUE" > /etc/container_environment/USE_STANDARD_PORTS