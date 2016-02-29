#! /bin/bash

#copy of https://github.com/RestComm/juju-charms/blob/master/mobicents-restcomm-charm/trusty/mobicents-restcomm/lib/mobicents/configuration/config-load-balancer.sh

##
## Description: Support external load balancer
## Author     : Gennadiy Dubina
##

BASEDIR=/opt/Restcomm-JBoss-AS7

configSipStack() {
	FILE="$BASEDIR/standalone/configuration/mss-sip-stack.properties"
	balancers=$1

	echo "Will change mss-sip-stack.properties using $balancers"

	sed -e 's|^#org.mobicents.ha.javax.sip.BALANCERS=|org.mobicents.ha.javax.sip.BALANCERS=|' $FILE > $FILE.bak
	mv $FILE.bak $FILE
	sed -e "s|org.mobicents.ha.javax.sip.BALANCERS=.*|org.mobicents.ha.javax.sip.BALANCERS=$balancers|" $FILE > $FILE.bak
	mv $FILE.bak $FILE
	echo "Activated Load Balancer on SIP stack configuration file with $balancers"

	sed -e 's|^#org.mobicents.ha.javax.sip.REACHABLE_CHECK=.*|org.mobicents.ha.javax.sip.REACHABLE_CHECK=false|' $FILE > $FILE.bak
	mv $FILE.bak $FILE

	echo 'Removed reachable checks and specified HTTP Port 8080'
}

configStandalone() {
	FILE="$BASEDIR/standalone/configuration/standalone-sip.xml"

	sed -e "s|path-name=\".*\" \(app-dispatcher-class=.*\)|path-name=\"org.mobicents.ha.balancing.only\" \1|g" $FILE > $FILE.bak
	mv -f $FILE.bak $FILE
	echo "changed the MSS Path Setting to org.mobicents.ha.balancing.only" 
}

if [ -n "$LOAD_BALANCERS" ]; then
	echo "Configure load balancers: ${LOAD_BALANCERS}"
	echo "Remove original configurator from restcomm"
	mv $BASEDIR/bin/restcomm/autoconfig.d/config-load-balancer.sh $BASEDIR/bin/restcomm/autoconfig.d/config-load-balancer.sh_origin
	echo "Apply config"
	configSipStack ${LOAD_BALANCERS}
	configStandalone
fi
