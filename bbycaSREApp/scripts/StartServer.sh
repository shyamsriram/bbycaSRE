#!/bin/sh

STAGING="/var/bbycasre/staging"
LOG="/var/log/bbycaSRE.log"
DEPLOYPATH="/opt/bbycaSRE/DEV"
ENV="DEV"
PORT="8000"

#Define Environment Variables for 
DEVENV="DEV"
DEVPORT="8001"
TESTENV="TEST"
TESTPORT="8002"
DRENV="DR"
DRPORT="8003"
PRODENV="PROD"
PRODPORT="8004"

source ~/.bashrc

date +"%d-%b-%Y %H:%M:%S (%Z) Executing Configuration ENV: $ENV PORT: $PORT DEPLOYPATH: $DEPLOYPATH DEPLOYMENT GRP: $DEPLOYMENT_GROUP_NAME" >> /var/log/bbycaSRE.log

# Set Env Variables Copy Deployment folder and Start Server
if [ "$DEPLOYMENT_GROUP_NAME" = "Development" ]
then

	export ENV=$DEVENV
	export PORT=$DEVPORT
	mkdir -p $DEPLOYPATH/$DEVENV

	cp -prf $STAGING/* $DEPLOYPATH/$DEVENV

	date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy Node Js Application...!!!" >> $LOG

	#Start the Server in background
	node $DEPLOYPATH/bbycaSREApp/src/bestbuy.ca.js 1>>$LOG 2>>$LOG &
else
	date +"%d-%b-%Y %H:%M:%S (%Z) Unknown Deployment Group: $DEPLOYMENT_GROUP_NAME Detected!!! Deployment has Failed!!!" >> $LOG
	#Fail and Exit
	exit 1
fi
