#!/bin/bash

function jsonval {
    temp=`cat /etc/container_environment.json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep  "CLI_"`
    if [ $? -eq 0 ] && [ -n "$temp" ];then
        while read -r clioption; do
        echo "option:$clioption"
        IFS=':' read ar1 ar2 <<< "$clioption"
         echo "$ar2 > /etc/container_environment/$ar1"
         echo -e "$ar2" | xargs > /etc/container_environment/$ar1
        done <<< "$temp"
    fi
}

    jsonval $variable
