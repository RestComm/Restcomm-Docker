#!/bin/bash
MemTotal=`awk '( $1 == "MemTotal:" ) { print $2/1048576 }' /proc/meminfo`
MemFree=`awk '( $1 == "MemFree:" ) { print $2/1048576 }' /proc/meminfo`
Buffers=`awk '( $1 == "Buffers:" ) { print $2/1048576 }' /proc/meminfo`
Cache=`awk '( $1 == "Cached:" ) { print $2/1048576 }' /proc/meminfo`
SwapTotal=`awk '( $1 == "SwapTotal:" ) { print $2/1048576 }' /proc/meminfo`
SwapFree=`awk '( $1 == "SwapFree:" ) { print $2/1048576 }' /proc/meminfo`

message={"\"host\"":"\"`echo $DOCKER_NAME`.restcomm.com\"","\"message\"":"\"Host_Heap\"","\"_MemTotal\"":"${MemTotal}","\"_MemFree\"":"${MemFree}","\"_Buffers\"":"${Buffers}","\"_Cache\"":"${Cache}","\"_SwapTotal\"":"${SwapTotal}","\"_SwapFree\"":"${SwapFree}"}
curl  -XPOST http://10.172.67.4:6666/gelf -p0 -d ${message}
