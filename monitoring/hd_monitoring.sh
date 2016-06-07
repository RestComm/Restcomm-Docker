#!/bin/bash

hdusage=`df -h | grep /dev/xvda1 |  awk -F " " '{print $5}'`
message={"\"host\"":"\"`echo $DOCKER_NAME`.restcomm.com\"","\"message\"":"\"${hdusage}\""}
curl  -XPOST http://10.172.67.4:5555/gelf -p0 -d ${message}

