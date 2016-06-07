#!/bin/bash

msprocess=`ps ax | grep java | grep mediaserver | head -1 | cut -d " " -f 2`

jvmvars=`/usr/lib/jvm/java-7-oracle/bin/java -cp /opt/resources/jvmtop.jar:/usr/lib/jvm/java-7-oracle/lib/tools.jar com.jvmtop.JvmTop -n1 --delay 3 --stat | grep ${msprocess} --line-buffered | sed -e "s/  */ /g" | sed -e "s/%//g" | cut -f4,5,6,7,8,9 -d ' ' `

IFS=" " read HPCUR HPMAX NHCUR NHMAX CPU GC <<< $jvmvars
message={"\"host\"":"\"`echo $DOCKER_NAME`.restcomm.com\"","\"message\"":"\"MS_JVM_STATS\"","\"_HPCUR\"":"${HPCUR}","\"_HPMAX\"":"${HPMAX}","\"_NHCUR\"":"${NHCUR}","\"_NHMAX\"":"${NHMAX}","\"_CPU\"":"${CPU}","\"_GC\"":"${GC}"}
curl  -XPOST http://10.172.67.4:7777/gelf -p0 -d ${message}