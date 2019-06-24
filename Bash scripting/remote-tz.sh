#!/bin/bash
set -x
date
DIST=$1
TZ=$2
if [ "$TZ" == "" ];
then
#	TZ="Asia/Tokyo"
#	TZ="Asia/Singapore"
#	TZ="Asia/Kolkata"
	TZ="UTC"
fi

if [ "$DIST" == "RHEL" -o "$DIST" == "CentOS" ];
then
	(echo "ZONE=$TZ"; echo "UTC=True") | sudo tee /etc/sysconfig/clock
	# sudo source /etc/sysconfig/clock
	date
	sudo cp /usr/share/zoneinfo/$TZ /etc/localtime
	date
else
	
	cat /etc/timezone
	echo "$TZ" | sudo tee /etc/timezone
	cat /etc/timezone
	sudo dpkg-reconfigure --frontend noninteractive tzdata
	date
fi
exit 0
