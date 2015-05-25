#!/bin/bash
#Maintainer George Vagenas - gvagenas@telestax.com

BASEDIR=/opt/Mobicents-Restcomm-JBoss-AS7

echo "Will check for enviroment variable and configure restcomm.conf"

if [ -n "$STATIC_ADDRESS" ]; then
  echo "STATIC_ADDRESS $STATIC_ADDRESS"
  sed -i "s/STATIC_ADDRESS=.*/STATIC_ADDRESS=$STATIC_ADDRESS/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$OUTBOUND_PROXY" ]; then
  echo "OUTBOUND_PROXY $OUTBOUND_PROXY"
  sed -i "s/OUTBOUND_PROXY=.*/OUTBOUND_PROXY=$OUTBOUND_PROXY/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$OUTBOUND_PROXY_USERNAME" ]; then
  echo "OUTBOUND_PROXY_USERNAME $OUTBOUND_PROXY_USERNAME"
  sed -i "s/OUTBOUND_PROXY_USERNAME=.*/OUTBOUND_PROXY_USERNAME=$OUTBOUND_PROXY_USERNAME/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$OUTBOUND_PROXY_PASSWORD" ]; then
  echo "OUTBOUND_PROXY_PASSWORD $OUTBOUND_PROXY_PASSWORD"
  sed -i "s/OUTBOUND_PROXY_PASSWORD=.*/OUTBOUND_PROXY_PASSWORD=$OUTBOUND_PROXY_PASSWORD/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$MEDIASERVER_LOWEST_PORT" ]; then
  echo "MEDIASERVER_LOWEST_PORT $MEDIASERVER_LOWEST_PORT"
  sed -i "s/MEDIASERVER_LOWEST_PORT=.*/MEDIASERVER_LOWEST_PORT=$MEDIASERVER_LOWEST_PORT/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$MEDIASERVER_HIGHEST_PORT" ]; then
  echo "MEDIASERVER_HIGHEST_PORT $MEDIASERVER_HIGHEST_PORT"
  sed -i "s/MEDIASERVER_HIGHEST_PORT=.*/MEDIASERVER_HIGHEST_PORT=$MEDIASERVER_HIGHEST_PORT/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$PROVISION_PROVIDER" ]; then
  echo "PROVISION_PROVIDER $PROVISION_PROVIDER"
  sed -i "s/PROVISION_PROVIDER=.*/PROVISION_PROVIDER=$PROVISION_PROVIDER/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_LOGIN" ]; then
  echo "DID_LOGIN $DID_LOGIN"
  sed -i "s/DID_LOGIN=.*/DID_LOGIN=$DID_LOGIN/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_PASSWORD" ]; then
  echo "DID_PASSWORD $DID_PASSWORD"
  sed -i "s/DID_PASSWORD=.*/DID_PASSWORD=$DID_PASSWORD/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_ENDPOINT" ]; then
  echo "DID_ENDPOINT $DID_ENDPOINT"
  sed -i "s/DID_ENDPOINT=.*/DID_ENDPOINT=$DID_ENDPOINT/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_SITEID" ]; then
  echo "DID_SITEID $DID_SITEID"
  sed -i "s/DID_SITEID=.*/DID_SITEID=$DID_SITEID/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$DID_ACCOUNTID" ]; then
  echo "DID_ACCOUNTID $DID_ACCOUNTID"
  sed -i "s/DID_ACCOUNTID=.*/DID_ACCOUNTID=$DID_ACCOUNTID/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$INTERFAX_USER" ]; then
  echo "INTERFAX_USER $INTERFAX_USER"
  sed -i "s/INTERFAX_USER=.*/INTERFAX_USER=$INTERFAX_USER/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$INTERFAX_PASSWORD" ]; then
  echo "INTERFAX_PASSWORD $INTERFAX_PASSWORD"
  sed -i "s/INTERFAX_PASSWORD=.*/INTERFAX_PASSWORD=$INTERFAX_PASSWORD/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ISPEECH_KEY" ]; then
  echo "ISPEECH_KEY $ISPEECH_KEY"
  sed -i "s/ISPEECH_KEY=.*/ISPEECH_KEY=$ISPEECH_KEY/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$VOICERSS_KEY" ]; then
  echo "VoiceRSS key: $VOICERSS_KEY"
  sed -i "s/VOICERSS_KEY=.*/VOICERSS_KEY=$VOICERSS_KEY/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ACAPELA_APPLICATION" ]; then
  echo "ACAPELA_APPLICATION $ACAPELA_APPLICATION"
  sed -i "s/ACAPELA_APPLICATION=.*/ACAPELA_APPLICATION=$ACAPELA_APPLICATION/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ACAPELA_LOGIN" ]; then
  echo "ACAPELA_LOGIN $ACAPELA_LOGIN"
  sed -i "s/ACAPELA_LOGIN=.*/ACAPELA_LOGIN=$ACAPELA_LOGIN/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$ACAPELA_PASSWORD" ]; then
  echo "ACAPELA_PASSWORD $ACAPELA_PASSWORD"
  sed -i "s/ACAPELA_PASSWORD=.*/ACAPELA_PASSWORD=$ACAPELA_PASSWORD/" $BASEDIR/bin/restcomm/restcomm.conf
fi

exec $BASEDIR/bin/restcomm/start-restcomm.sh
