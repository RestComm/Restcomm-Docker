#!/bin/bash
#Maintainer George Vagenas - gvagenas@telestax.com

BASEDIR=/opt/Mobicents-Restcomm-JBoss-AS7

echo "VoiceRSS key: $VOICERSS_KEY"

sed -i "s/VOICERSS_KEY=.*/VOICERSS_KEY=$VOICERSS_KEY/" $BASEDIR/bin/restcomm/restcomm.conf

exec $BASEDIR/bin/restcomm/start-restcomm.sh
