#!/bin/bash

LONGLAT=
if [ -f /var/register/GPSLocationSimulation ]; then 
LONGLAT=$(cat /var/register/LocationInfo | grep -E "longitude|latitude" | awk '{ print $NF }' | tr '\n' ' ' 2>/dev/null)
echo "${LONGLAT}"
exit
fi
LTEMODEMS=$(mmcli -L  2>&1 | egrep -v "error|No modems"  | awk '{ print $1 }' | cut -d/ -f6 2>/dev/null)

for MM_NUM in ${LTEMODEMS}
do
    LONGLAT=$(mmcli -m $MM_NUM --location-get | grep -E "longitude|latitude" | awk '{ print $NF }' | tr '\n' ' ' 2>/dev/null)
    if [ ! -z "$LONGLAT" ]; then
        echo "${LONGLAT}"
        exit 0
    fi
done

if [ -z "${LONGLAT}" ]; then
    echo undefined
    exit 0
fi
