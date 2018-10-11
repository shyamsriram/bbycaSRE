#!/bin/sh

LOG="/var/log/bbycaSRE.log"

#Stop the Server only if node instance is running
running=`ps -ef|grep node|grep -v grep`

if [ "$running" == "" ] 
then
	date +"%d-%b-%Y %H:%M:%S (%Z) Best Buy Node is not Running, Nothing to kill...." >> $LOG 
	exit 0
else
	date +"%d-%b-%Y %H:%M:%S (%Z) Stopping Best Buy Node JS Application...." >> $LOG 
	killall node
fi
