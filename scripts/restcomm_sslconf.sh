#!/bin/bash
#Maintainer George Vagenas - gvagenas@telestax.com
#Maintainer Jean Deruelle - jean.deruelle@telestax.com
#Maintainer Lefteris Banos -liblefty@telestax.com

source /etc/container_environment.sh

BASEDIR=/opt/Restcomm-JBoss-AS7

TRUSTSTORE_FILE_NAME=restcomm-combined.jks
TRUSTSTORE_FILE=$BASEDIR/standalone/configuration/$TRUSTSTORE_FILE_NAME
DERFILE=$BASEDIR/ca-authority.der
CONFFILE=/tmp/conf.sh


function download_conf(){
echo "url $1 $2 $3"
if [[ `wget -S --spider $1 $2 $3 2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
           if [ -n "$2" ] && [ -n "$3" ]; then
                wget $1 $2 $3 -O $4
           else
                wget $1 -O $2
            fi
                return 0;
        else
                echo "false"
                exit 1;
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
  if [[ "$SECURESSL" = "SELF" ||  "$SECURESSL" = "AUTH" ]]; then
      # Add StartComm certificate to the truststore to avoid SSL Exception when fetching the URL
      keytool -importcert -alias startssl -keystore /usr/lib/jvm/java-7-oracle/jre/lib/security/cacerts -storepass changeit -file $BASEDIR/ca-startcom.der -noprompt

      sed -i "s/DISABLE_HTTP=.*/DISABLE_HTTP='true'/" $BASEDIR/bin/restcomm/restcomm.conf
      sed -i "s/TRUSTSTORE_FILE=.*/TRUSTSTORE_FILE='$TRUSTSTORE_FILE_NAME'/" $BASEDIR/bin/restcomm/restcomm.conf

      if [ -n "$RVD_PORT" ]; then
            echo "RVD_PORT $RVD_PORT"
            #If used means that port mapping (e.g: -p 445:443) is not the default (-p 443:443)
            sed -i "s|<restcommBaseUrl>.*</restcommBaseUrl>|<restcommBaseUrl>https://${STATIC_ADDRESS}:${RVD_PORT}/</restcommBaseUrl>|" $BASEDIR/standalone/deployments/restcomm-rvd.war/WEB-INF/rvd.xml
      fi

      #Certificate setup (Authority certificate or self-signed)
      if [ "$SECURESSL" = "AUTH" ]; then
        keytool -importcert -alias $TRUSTSTORE_ALIAS -keystore $TRUSTSTORE_FILE -storepass $TRUSTSTORE_PASSWORD -file $BASEDIR/ca-authority.der -noprompt
      elif [ "$SECURESSL" = "SELF"  ]; then
        echo "TRUSTSTORE_FILE is not provided but SECURE is TRUE. We will create and configure self signed certificate"

         TRUSTSTORE_LOCATION=$TRUSTSTORE_FILE
        if [ -n "$RESTCOMMHOST" ]; then
            HOSTNAME=`echo $RESTCOMMHOST`
            keytool -genkey -alias $TRUSTSTORE_ALIAS -keyalg RSA -keystore $TRUSTSTORE_LOCATION -dname "CN=$HOSTNAME" -storepass $TRUSTSTORE_PASSWORD -keypass $TRUSTSTORE_PASSWORD
        else
            HOSTNAME=`echo $STATIC_ADDRESS`
            keytool -genkey -alias $TRUSTSTORE_ALIAS -keyalg RSA -keystore $TRUSTSTORE_LOCATION -dname "CN=restcomm" -ext san=ip:"$HOSTNAME" -storepass $TRUSTSTORE_PASSWORD -keypass $TRUSTSTORE_PASSWORD
        fi
        echo $HOSTNAME

        echo "The generated truststore file at $TRUSTSTORE_LOCATION "
      fi

      sed -i "s|protocol=\"TLSv1,TLSv1.1,TLSv1.2\"|protocol=\"TLSv1,TLSv1.1,TLSv1.2,SSLv2Hello\"|" $BASEDIR/standalone/configuration/standalone-sip.xml
      grep -q 'ephemeralDHKeySize' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Djdk.tls.ephemeralDHKeySize=2048|" $BASEDIR/bin/standalone.conf

      if [[ "$SSLSNI" = "FALSE" ]]; then
            grep -q 'allowLegacyHelloMessages' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Dsun.security.ssl.allowLegacyHelloMessages=false -Djsse.enableSNIExtension=false|" $BASEDIR/bin/standalone.conf
      else
             grep -q 'allowLegacyHelloMessages' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Dsun.security.ssl.allowLegacyHelloMessages=false -Djsse.enableSNIExtension=true|" $BASEDIR/bin/standalone.conf
      fi
      grep -q 'https.protocols' $BASEDIR/bin/standalone.conf || sed -i "s|-Djava.awt.headless=true|& -Dhttps.protocols=TLSv1.1,TLSv1.2|" $BASEDIR/bin/standalone.conf

      grep -q 'connector name="sip-wss"' $BASEDIR/standalone/configuration/standalone-sip.xml || sed -i '/connector name=\"sip-ws\".*/ a \
        \ <connector name="sip-wss" protocol="SIP/2.0" scheme="sip" socket-binding="sip-wss"/>
        ' $BASEDIR/standalone/configuration/standalone-sip.xml
      grep -q 'binding name="sip-wss"' $BASEDIR/standalone/configuration/standalone-sip.xml || sed -i '/binding name=\"sip-ws\".*/ a \
        \<socket-binding name="sip-wss" port="5083"/>' $BASEDIR/standalone/configuration/standalone-sip.xml
       grep -q 'gov.nist.javax.sip.TLS_CLIENT_AUTH_TYPE=Disabled' $BASEDIR/standalone/configuration/mss-sip-stack.properties ||
       sed -i '/org.mobicents.ha.javax.sip.LOCAL_SSL_PORT=443/ a \
      \gov.nist.javax.sip.TLS_CLIENT_AUTH_TYPE=Disabled\
      \javax.net.ssl.keyStore='"$TRUSTSTORE_FILE"'\
      \javax.net.ssl.keyStorePassword='"`echo $TRUSTSTORE_PASSWORD`"'\
      \javax.net.ssl.trustStorePassword='"`echo $TRUSTSTORE_PASSWORD`"'\
      \javax.net.ssl.trustStore='"$TRUSTSTORE_FILE"'\
      \javax.net.ssl.keyStoreType=JKS' $BASEDIR/standalone/configuration/mss-sip-stack.properties
   else
       if [ -n "$RVD_PORT" ]; then
            echo "RVD_PORT $RVD_PORT"
            #If used means that port mapping (e.g: -p 85:80) is not the default (-p 80:80)
            sed -i "s|<restcommBaseUrl>.*</restcommBaseUrl>|<restcommBaseUrl>http://${STATIC_ADDRESS}:${RVD_PORT}/</restcommBaseUrl>|" $BASEDIR/standalone/deployments/restcomm-rvd.war/WEB-INF/rvd.xml
      fi
   fi
fi


if [  "${USE_STANDARD_SIP_PORTS^^}" = "TRUE"  ] ; then
      sed -i "s|5083|5063|" $BASEDIR/bin/restcomm/autoconfig.d/config-sip-connectors.sh
      sed -i "s|5083|5063|" $BASEDIR/standalone/configuration/standalone-sip.xml
fi

if [ -n "$PORT_OFFSET" ]; then
    if [  "${USE_STANDARD_SIP_PORTS^^}" = "TRUE"  ]; then
        wss=$((5063 + $PORT_OFFSET))
         sed -i "s|5063|${wss}|" $BASEDIR/bin/restcomm/autoconfig.d/config-sip-connectors.sh
         sed -i "s|5063|${wss}|" $BASEDIR/standalone/configuration/standalone-sip.xml
    else
         sed -i "s|5083|${wss}|" $BASEDIR/bin/restcomm/autoconfig.d/config-sip-connectors.sh
         sed -i "s|5083|${wss}|" $BASEDIR/standalone/configuration/standalone-sip.xml
    fi
fi
