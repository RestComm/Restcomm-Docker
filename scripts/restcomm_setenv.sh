#!/bin/bash


getOptions() {
    cat /etc/container_environment.json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g'  | grep "^$1"
}

function jsonval {
    temp=$(getOptions $1)
    echo "temp:$temp"
    if [ $? -eq 0 ] && [ -n "$temp" ];then
        while read -r option; do
        echo "option:$option"
        IFS=':' read ar1 ar2 <<< "$option"
         echo "$ar2 > /etc/container_environment/$ar1"
         echo -e "$ar2" | xargs > /etc/container_environment/$ar1
        done <<< "$temp"
    fi
}

OPTS=( "RCBCONF_" "RCADVCONF_" "EXTCONF_" "LBCONF_" "RMSCONF_" "CLI_")

  for opt in "${OPTS[@]}"; do
        echo "opt:$opt"
       jsonval $opt
   done
