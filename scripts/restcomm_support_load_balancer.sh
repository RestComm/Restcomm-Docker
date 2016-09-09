#! /bin/bash
##
## Description: Support external load balancer
## Author     : Gennadiy Dubina
##

BASEDIR=/opt/Restcomm-JBoss-AS7

configIP() {
if [ -z "$LB_PUBLIC_IP" ]; then echo "Need to set LB_PUBLIC_IP"; exit 1;
else
    sed -i "s|ACTIVATE_LB=.*|ACTIVATE_LB=${ACTIVATE_LB}|"   $BASEDIR/bin/restcomm/advanced.conf
	echo "LB_PUBLIC_IP $LB_PUBLIC_IP"
    sed -i "s|LB_PUBLIC_IP=.*|LB_PUBLIC_IP=${LB_PUBLIC_IP}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_INTERNAL_IP" ]; then
  echo "LB_INTERNAL_IP $LB_INTERNAL_IP"
  sed -i "s|LB_INTERNAL_IP=.*|LB_INTERNAL_IP=${LB_INTERNAL_IP}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
}

configPorts() {
if [ -n "$LB_INTERNAL_PORT_UDP" ]; then
  echo "LB_INTERNAL_PORT_UDP $LB_INTERNAL_PORT_UDP"
  sed -i "s|LB_INTERNAL_PORT_UDP=.*|LB_INTERNAL_PORT_UDP=${LB_INTERNAL_PORT_UDP}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_INTERNAL_PORT_TCP" ]; then
  echo "LB_INTERNAL_PORT_TCP $LB_INTERNAL_PORT_TCP"
  sed -i "s|LB_INTERNAL_PORT_TCP=.*|LB_INTERNAL_PORT_TCP=${LB_INTERNAL_PORT_TCP}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_INTERNAL_PORT_TLS" ]; then
  echo "LB_INTERNAL_PORT_TLS $LB_INTERNAL_PORT_TLS"
  sed -i "s|LB_INTERNAL_PORT_TLS=.*|LB_INTERNAL_PORT_TLS=${LB_INTERNAL_PORT_TLS}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_INTERNAL_PORT_WS" ]; then
  echo "LB_INTERNAL_PORT_WS $LB_INTERNAL_PORT_WS"
  sed -i "s|LB_INTERNAL_PORT_WS=.*|LB_INTERNAL_PORT_WS=${LB_INTERNAL_PORT_WS}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_INTERNAL_PORT_WSS" ]; then
  echo "LB_INTERNAL_PORT_WSS $LB_INTERNAL_PORT_WSS"
  sed -i "s|LB_INTERNAL_PORT_WSS=.*|LB_INTERNAL_PORT_WSS=${LB_INTERNAL_PORT_WSS}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_RMI_PORT" ]; then
  echo "LB_RMI_PORT $LB_RMI_PORT"
  sed -i "s|LB_RMI_PORT=.*|LB_RMI_PORT=${LB_RMI_PORT}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_EXTERNAL_PORT_UDP" ]; then
  echo "LB_EXTERNAL_PORT_UDP $LB_EXTERNAL_PORT_UDP"
  sed -i "s|LB_EXTERNAL_PORT_UDP=.*|LB_EXTERNAL_PORT_UDP=${LB_EXTERNAL_PORT_UDP}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_EXTERNAL_PORT_TCP" ]; then
  echo "LB_EXTERNAL_PORT_TCP $LB_EXTERNAL_PORT_TCP"
  sed -i "s|LB_EXTERNAL_PORT_TCP=.*|LB_EXTERNAL_PORT_TCP=${LB_EXTERNAL_PORT_TCP}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_EXTERNAL_PORT_TLS" ]; then
  echo "LB_EXTERNAL_PORT_TLS $LB_EXTERNAL_PORT_TLS"
  sed -i "s|LB_EXTERNAL_PORT_TLS=.*|LB_EXTERNAL_PORT_TLS=${LB_EXTERNAL_PORT_TLS}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_EXTERNAL_PORT_WS" ]; then
  echo "LB_EXTERNAL_PORT_WS $LB_EXTERNAL_PORT_WS"
  sed -i "s|LB_EXTERNAL_PORT_WS=.*|LB_EXTERNAL_PORT_WS=${LB_EXTERNAL_PORT_WS}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LB_EXTERNAL_PORT_WSS" ]; then
  echo "LB_EXTERNAL_PORT_WSS $LB_EXTERNAL_PORT_WSS"
  sed -i "s|LB_EXTERNAL_PORT_WSS=.*|LB_EXTERNAL_PORT_WSS=${LB_EXTERNAL_PORT_WSS}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
if [ -n "$LBHOST" ]; then
  echo "LBHOST $LBHOST"
  sed -i "s|LBHOST=.*|LBHOST=${LBHOST}|"   $BASEDIR/bin/restcomm/advanced.conf
fi
}

if [  "${ACTIVATE_LB^^}" = "TRUE"  ]; then
	echo "Configure load balancers..."
	configIP
	configPorts
fi


#auto delete script after run once. No need more.
rm -- "$0"