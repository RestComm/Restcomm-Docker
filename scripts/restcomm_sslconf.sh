#!/bin/bash
#Maintainer George Vagenas - gvagenas@telestax.com
#Maintainer Jean Deruelle - jean.deruelle@telestax.com
#Maintainer Lefteris Banos -liblefty@telestax.com

source /etc/container_environment.sh

BASEDIR=/opt/Mobicents-Restcomm-JBoss-AS7

TRUSTSTORE_FILE_NAME=restcomm-combined.jks
TRUSTSTORE_FILE=$BASEDIR/standalone/configuration/$TRUSTSTORE_FILE_NAME
DERFILE=$BASEDIR/ca-authority.der
CONFFILE=/tmp/conf.sh





function download_conf(){
echo "url $1 $2 $3"
if [[ `wget -S --spider $1 $2 $3 2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
                wget $1 $2 $3 -O $4
                return 0;
        else
                echo "false"
                return 1
  fi
}

if [ -n "$TRUSTSTORE_PASSWORD" ]; then
	sed -i "s/TRUSTSTORE_PASSWORD=.*/TRUSTSTORE_PASSWORD='`echo $TRUSTSTORE_PASSWORD`'/" $BASEDIR/bin/restcomm/restcomm.conf
fi

if [ -n "$TRUSTSTORE_ALIAS" ]; then
	sed -i "s/TRUSTSTORE_ALIAS=.*/TRUSTSTORE_ALIAS='`echo $TRUSTSTORE_ALIAS`'/" $BASEDIR/bin/restcomm/restcomm.conf
fi


if [ -n "$CERTCONFURL" ]; then
  echo "Certification file URL is: $CERTCONFURL"
  if [ -n "$CERTREPOUSR"  ] && [ -n "$CERTREPOPWRD" ]; then
  		USR="--user=`echo $CERTREPOUSR`"
  		PASS="--password=`echo $CERTREPOPWRD`"
  fi
   URL="$CERTCONFURL $USR $PASS"
   download_conf $URL $TRUSTSTORE_FILE
fi

if [ -n "$DERCONFURL" ]; then
  echo "Der file URL is: $DERCONFURL "
  if [ -n "$DERREPOUSR" ] && [ -n "$DERREPOPWRD" ]; then
  		USR="--user=`echo $DERREPOUSR`"
  		PASS="--password=`echo $DERREPOPWRD`"
  fi
   URL="$DERCONFURL $USR $PASS"
   download_conf $URL $DERFILE
fi

if [ -n "$SECURESSL" ]; then
  echo "SECURE $SECURESSL"
  # Add StartComm certificate to the truststore to avoid SSL Exception when fetching the URL
  keytool -importcert -alias startssl -keystore /usr/lib/jvm/java-7-oracle/jre/lib/security/cacerts -storepass changeit -file $BASEDIR/ca-startcom.der -noprompt

  sed -i "s/DISABLE_HTTP=.*/DISABLE_HTTP='true'/" $BASEDIR/bin/restcomm/restcomm.conf
  sed -i "s/TRUSTSTORE_FILE=.*/TRUSTSTORE_FILE='$TRUSTSTORE_FILE_NAME'/" $BASEDIR/bin/restcomm/restcomm.conf
  #Certificate setup (Authority certificate or self-signed)
  if [ "$SECURESSL" = "AUTH" ]; then
    keytool -importcert -alias startssl -keystore $TRUSTSTORE_FILE -storepass $TRUSTSTORE_PASSWORD -file $BASEDIR/ca-authority.der -noprompt
  elif [ "$SECURESSL" = "SELF"  ]; then
    echo "TRUSTSTORE_FILE is not provided but SECURE is TRUE. We will create and configure self signed certificate"
    #HOSTNAME=`echo $RESTCOMMHOST`
    HOSTNAME=`hostname`
    echo $HOSTNAME
    TRUSTSTORE_LOCATION=$TRUSTSTORE_FILE
    keytool -genkey -alias $TRUSTSTORE_ALIAS -keyalg RSA -keystore $TRUSTSTORE_LOCATION -dname "CN=$HOSTNAME" -storepass $TRUSTSTORE_PASSWORD -keypass $TRUSTSTORE_PASSWORD
    echo "The generated truststore file at $TRUSTSTORE_LOCATION "
  fi

  sed -i "s|protocol=\"TLSv1,TLSv1.1,TLSv1.2\"|protocol=\"TLSv1,TLSv1.1,TLSv1.2,SSLv2Hello\"|" $BASEDIR/standalone/configuration/standalone-sip.xml
  grep -q 'ephemeralDHKeySize' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Djdk.tls.ephemeralDHKeySize=2048|" $BASEDIR/bin/standalone.conf
  grep -q 'allowLegacyHelloMessages' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Dsun.security.ssl.allowLegacyHelloMessages=false -Djsse.enableSNIExtension=false|" $BASEDIR/bin/standalone.conf
  grep -q 'https.protocols' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Dhttps.protocols=TLSv1.1,TLSv1.2|" $BASEDIR/bin/standalone.conf

  grep -q 'connector name="sip-wss"' $BASEDIR/standalone/configuration/standalone-sip.xml || sed -i '/connector name=\"sip-ws\".*/ a \
	\ <connector name="sip-wss" protocol="SIP/2.0" scheme="sip" socket-binding="sip-wss"/>
	' $BASEDIR/standalone/configuration/standalone-sip.xml
  if [ -n "$STATIC_ADDRESS" ]; then
	sed -i "s|<connector name=\"sip-wss\" .*/>|<connector name=\"sip-wss\" protocol=\"SIP/2.0\" scheme=\"sip\" socket-binding=\"sip-wss\" use-static-address=\"true\" static-server-address=\"$STATIC_ADDRESS\" static-server-port=\"5083\"/>|" $BASEDIR/standalone/configuration/standalone-sip.xml
  fi
  grep -q 'binding name="sip-wss"' $BASEDIR/standalone/configuration/standalone-sip.xml || sed -i '/binding name=\"sip-ws\".*/ a \
	\<socket-binding name="sip-wss" port="5083"/>' $BASEDIR/standalone/configuration/standalone-sip.xml
   grep -q 'gov.nist.javax.sip.TLS_CLIENT_AUTH_TYPE=Disabled' $BASEDIR/standalone/configuration/mss-sip-stack.properties ||
   sed -i '/org.mobicents.ha.javax.sip.LOCAL_SSL_PORT=8443/ a \
  \gov.nist.javax.sip.TLS_CLIENT_AUTH_TYPE=Disabled\
  \javax.net.ssl.keyStore=/opt/Mobicents-Restcomm-JBoss-AS7/standalone/configuration/$TRUSTSTORE_FILE\
  \javax.net.ssl.keyStorePassword=`echo $TRUSTSTORE_PASSWORD`\
  \javax.net.ssl.trustStorePassword=`echo $TRUSTSTORE_PASSWORD`\
  \javax.net.ssl.trustStore=/opt/Mobicents-Restcomm-JBoss-AS7/standalone/configuration/$TRUSTSTORE_FILE\
  \javax.net.ssl.keyStoreType=JKS' $BASEDIR/standalone/configuration/mss-sip-stack.properties
fi