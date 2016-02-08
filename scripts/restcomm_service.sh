#!/bin/bash

BASEDIR=/opt/Restcomm-JBoss-AS7

grep -q 'telestax' $BASEDIR/standalone/configuration/mgmt-users.properties || exec $BASEDIR/bin/add-user.sh telestax "1 l0ve 43stc0mmaaS" -s
export RUN_DOCKER=true
exec $BASEDIR/bin/restcomm/start-restcomm.sh
