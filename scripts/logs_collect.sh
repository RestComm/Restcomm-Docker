#!/bin/bash

DATE=$(date +%F_%H:%M)
DIR_NAME=restcomm_$DATE


RESTCOMM_CORE_FILE=server.log
MEDIASERVER_FILE=server.log
SYSLOGS_DIR=/var/log

BASEDIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
RESTCOMM_LOG_BASE=$(cd $BASEDIR/../../ && pwd)
RESTCOMM_CORE_LOG=$RESTCOMM_LOG_BASE/standalone/log
MMS_LOGS=$RESTCOMM_LOG_BASE/mediaserver/log


restcomm_logs () {
 if [ -d "$LOGS_DIR_ZIP" ]; then
  cp $RESTCOMM_CORE_LOG/$RESTCOMM_CORE_FILE $LOGS_DIR_ZIP/
  return 0
 fi
   exit 1
}

restcomm_logs_bytime () {
 if [ -d "$LOGS_DIR_ZIP" ]; then
  IN=$1
  IFS=","
  arr=($IN)
  unset IFS
  FROM=`grep -n "^${arr[0]}"  $RESTCOMM_CORE_LOG/$RESTCOMM_CORE_FILE |cut -f1 -d: | tail -1`
  TO=`grep -n "^${arr[1]}"  $RESTCOMM_CORE_LOG/$RESTCOMM_CORE_FILE |cut -f1 -d: | tail -1`
  awk 'NR=="'"$FROM"'", NR=="'"$TO"'"; NR=="'"$TO"'" {print; exit}' $RESTCOMM_CORE_LOG/$RESTCOMM_CORE_FILE > $LOGS_DIR_ZIP/RestCommlinesTime.log
  return 0
 fi
   exit 1
}

mediaserver_logs () {
if [ -d "$LOGS_DIR_ZIP" ]; then
  cp $MMS_LOGS/$MEDIASERVER_FILE $LOGS_DIR_ZIP/
  return 0
 fi
   exit 1
}

system_logs () {
if [ -d "$LOGS_DIR_ZIP" ]; then
    cp $SYSLOGS_DIR/messages $LOGS_DIR_ZIP/
    cp $SYSLOGS_DIR/syslog $LOGS_DIR_ZIP/
  return 0
 fi
   exit 1
}

JVM_perfo_stats () {
if [ -d "$LOGS_DIR_ZIP" ]; then
    ps ax | grep java | grep jboss | head -1 | cut -d " " -f 3 | xargs  jstack -l   >  $LOGS_DIR_ZIP/restcomm_jstack_trace_$DATE
    ps ax | grep java | grep mediaserver | head -1 | cut -d " " -f 3 | xargs  jstack -l >  $LOGS_DIR_ZIP/mms_jstack_trace_$DATE
  return 0
 fi
   exit 1
}

system_usage_info () {
if [ -d "$LOGS_DIR_ZIP" ]; then
   echo CPU\(s\): `top -b -n1 | grep "Cpu(s)" | awk '{print $2" : " $4}'` >  $LOGS_DIR_ZIP/usage_stats_$DATE
   echo  >> $LOGS_DIR_ZIP/usage_stats_$DATE
   top -b -n1 | grep Mem >> $LOGS_DIR_ZIP/usage_stats_$DATE
   ps aux  > $LOGS_DIR_ZIP/top_$DATE
  return 0
 fi
   exit 1
}


jvm_process_info () {
if [ -d "$LOGS_DIR_ZIP" ]; then
   echo "----------------------- restcomm ---------------------------" > $LOGS_DIR_ZIP/jvm_process_$DATE
   echo "--------New Generation Heap-------" >> $LOGS_DIR_ZIP/jvm_process_$DATE
   ps ax | grep java | grep jboss | head -1 | cut -d " " -f 3 | xargs jstat -gcnew >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo "--------New Generation Space Size-------" >> $LOGS_DIR_ZIP/jvm_process_$DATE
   ps ax | grep java | grep jboss | head -1 | cut -d " " -f 3 | xargs jstat -gcnewcapacity >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo "--------Garbage-collected heap-------" >> $LOGS_DIR_ZIP/jvm_process_$DATE
   ps ax | grep java | grep jboss | head -1 | cut -d " " -f 3 | xargs jstat  -gc >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo "----------------------- mediaserver ---------------------------" >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo "-------- New Generation Heap -------" >> $LOGS_DIR_ZIP/jvm_process_$DATE
   ps ax | grep java | grep mediaserver | head -1 | cut -d " " -f 3 | xargs jstat -gcnew >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo "--------New Generation Space Size-------" >> $LOGS_DIR_ZIP/jvm_process_$DATE
   ps ax | grep java | grep mediaserver | head -1 | cut -d " " -f 3 | xargs jstat -gcnewcapacity >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo "--------Garbage-collected heap-------" >> $LOGS_DIR_ZIP/jvm_process_$DATE
   ps ax | grep java | grep mediaserver | head -1 | cut -d " " -f 3 | xargs jstat -gc >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo "--------------------------------- ---------------------------" >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo "----------------------- More INFO ---------------------------" >> $LOGS_DIR_ZIP/jvm_process_$DATE
   echo "  http://docs.oracle.com/javase/7/docs/technotes/tools/share/jstat.html " >> $LOGS_DIR_ZIP/jvm_process_$DATE
  return 0
 fi
   exit 1
}

LWP_threads_logs () {
if [ -d "$LOGS_DIR_ZIP" ]; then
    pat=`ps -ef | grep java | grep -v grep | awk '{print $2}'`
    ps -eLo pid,lwp,nlwp,ruser,pcpu,stime,etime,args | grep -F "${pat}" > $LOGS_DIR_ZIP/lwpthread_$DATE.txt
    return 0
 fi
   exit 1
}

netstat_stats () {

if [ -d "$LOGS_DIR_ZIP" ]; then
  echo "----------------------- netstat -s ---------------------------" > $LOGS_DIR_ZIP/netstat_stats_$DATE
  netstat -s >> $LOGS_DIR_ZIP/netstat_stats_$DATE
  echo  >> $LOGS_DIR_ZIP/netstat_stats_$DATE
  echo  >> $LOGS_DIR_ZIP/netstat_stats_$DATE
  echo "----------------------- netstat -anp ---------------------------" >> $LOGS_DIR_ZIP/netstat_stats_$DATE
  netstat -anp >> $LOGS_DIR_ZIP/netstat_stats_$DATE
  return 0
 fi
   exit 1
}



make_tar () {
 if [ -d "$LOGS_DIR_ZIP" ]; then
     tar -zcf $RESTCOMM_CORE_LOG/`echo $DIR_NAME | tr -d :`.tar.gz -C $LOGS_DIR_ZIP . 3>&1 1>&2 2>&3
     rm -rf $LOGS_DIR_ZIP
     return 0
 fi
   exit 1
}

set_info() {
if [ -d "$LOGS_DIR_ZIP" ]; then
  echo "$1" >  $LOGS_DIR_ZIP/issue_info.txt
  return 0
 fi
   exit 1
}

usage () {
   cat << EOF
Usage: failure_logs_collect.sh  <options>

options:
-m : optional message of the problem.
-t : Restcomm log file time extractor (e.g "06:20:0*,06:23:0*").
-h : prints this message
-z : Create .tar file
EOF
   exit 1
}

#MAIN
tflag=false
zflag=false
TEMP=`getopt --long -o ":t:m:h" "$@"`
eval set -- "$TEMP"
while true ; do
    case "$1" in
        -m )
           mkdir -p $LOGS_DIR_ZIP
           set_info "$2"
           shift 2
        ;;
        -t )
           tflag=true
           var=$2
           shift 2
        ;;
         -z )
           zflag=true
        ;;
        -h )
           usage
        ;;
        *)
            break
        ;;
    esac
done;

if [ ! -e $LOGS_DIR_ZIP ]; then
   echo "create DIR $LOGS_DIR_ZIP"
   mkdir -p $LOGS_DIR_ZIP
fi

restcomm_logs
mediaserver_logs
system_logs
JVM_perfo_stats
jvm_process_info
LWP_threads_logs
system_usage_info
netstat_stats

if $tflag ; then
    restcomm_logs_bytime $var
fi
if $zflag ; then
   make_tar
fi


echo TAR_FILE : $RESTCOMM_LOGS/`echo $DIR_NAME | tr -d :`.tar.gz