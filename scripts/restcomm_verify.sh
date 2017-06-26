#!/bin/bash

mem=$(awk '/^MemTotal:/{print $2}' /proc/meminfo)

if [ "$mem" -lt "4000000" ]; then
    echo "ERROR: $mem of RAM is not enough to start Telestax RestComm. Min required value is 4000000"
    exit 1
fi

exit 0