#!/bin/bash

BASEDIR=/opt/Restcomm-JBoss-AS7

grep -q 'telestax' $BASEDIR/standalone/configuration/mgmt-users.properties || exec $BASEDIR/bin/add-user.sh telestax "RestComm" -s
export RUN_DOCKER=true
exec $BASEDIR/bin/restcomm/start-restcomm.sh
