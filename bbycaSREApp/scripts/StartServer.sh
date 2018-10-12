#!/bin/sh

#Initialize Paths
STAGING="/var/bbycasre/staging"
LOG="/var/log/bbycaSRE.log"
DEPLOYPATH="/opt/bbycaSRE"

#Define Environment Variables for DEV, TEST, DR and PROD 
#Development
DEVENV="DEV"
DEVPORT="8001"

#Test
TESTENV="TEST"
TESTPORT="8002"

#Disaster Recovery
DRENV="DR"
DRPORT="8003"

#Production
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
	cp -prf $STAGING/bbycaSREApp $DEPLOYPATH/$DEVENV
	date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy $ENV Node Js Application...!!!" >> $LOG
	#Start the Server in background
	node $DEPLOYPATH/$DEVENV/bbycaSREApp/src/bestbuy.ca.js 1>>$LOG 2>>$LOG &

elif [ "$DEPLOYMENT_GROUP_NAME" = "Test" ]
then
	export ENV=$TESTENV
	export PORT=$TESTPORT
	mkdir -p $DEPLOYPATH/$TESTENV
	cp -prf $STAGING/bbycaSREApp $DEPLOYPATH/$TESTENV
	date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy $ENV Node Js Application...!!!" >> $LOG
	#Start the Server in background
	node $DEPLOYPATH/$TESTENV/bbycaSREApp/src/bestbuy.ca.js 1>>$LOG 2>>$LOG &

elif [ "$DEPLOYMENT_GROUP_NAME" = "Disaster" ]
then
	export ENV=$DRENV
	export PORT=$DRPORT
	mkdir -p $DEPLOYPATH/$DRENV
	cp -prf $STAGING/bbycaSREApp $DEPLOYPATH/$DRENV
	date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy $ENV Node Js Application...!!!" >> $LOG
	#Start the Server in background
	node $DEPLOYPATH/$DRENV/bbycaSREApp/src/bestbuy.ca.js 1>>$LOG 2>>$LOG &

elif [ "$DEPLOYMENT_GROUP_NAME" = "Production" ]
then
	export ENV=$PRODENV
	export PORT=$PRODPORT
	mkdir -p $DEPLOYPATH/$PRODENV
	cp -prf $STAGING/bbycaSREApp $DEPLOYPATH/$PRODENV
	date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy $ENV Node Js Application...!!!" >> $LOG
	#Start the Server in background
	node $DEPLOYPATH/$PRODENV/bbycaSREApp/src/bestbuy.ca.js 1>>$LOG 2>>$LOG &

elif [ "$DEPLOYMENT_GROUP_NAME" = "All" ]
then
	#If all Deployments was simultaneously selected, then Start Up all Server instances
	
	#Development	
	export ENV=$DEVENV
	export PORT=$DEVPORT
	mkdir -p $DEPLOYPATH/$DEVENV
	cp -prf $STAGING/bbycaSREApp $DEPLOYPATH/$DEVENV
	date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy DEV Node Js Application...!!!" >> $LOG
	node $DEPLOYPATH/$DEVENV/bbycaSREApp/src/bestbuy.ca.js 1>>$LOG 2>>$LOG &

	#Test
	export ENV=$TESTENV
	export PORT=$TESTPORT
	mkdir -p $DEPLOYPATH/$TESTENV
	cp -prf $STAGING/bbycaSREApp $DEPLOYPATH/$TESTENV
	date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy TEST Node Js Application...!!!" >> $LOG
	node $DEPLOYPATH/$TESTENV/bbycaSREApp/src/bestbuy.ca.js 1>>$LOG 2>>$LOG &

	#Disaster
	export ENV=$DRENV
	export PORT=$DRPORT
	mkdir -p $DEPLOYPATH/$DRENV
	cp -prf $STAGING/bbycaSREApp $DEPLOYPATH/$DRENV
	date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy DR Node Js Application...!!!" >> $LOG
	node $DEPLOYPATH/$DRENV/bbycaSREApp/src/bestbuy.ca.js 1>>$LOG 2>>$LOG &

	#Production		
	export ENV=$PRODENV
	export PORT=$PRODPORT
	mkdir -p $DEPLOYPATH/$PRODENV
	cp -prf $STAGING/bbycaSREApp $DEPLOYPATH/$PRODENV
	date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy PROD Node Js Application...!!!" >> $LOG
	node $DEPLOYPATH/$PRODENV/bbycaSREApp/src/bestbuy.ca.js 1>>$LOG 2>>$LOG &

else
	date +"%d-%b-%Y %H:%M:%S (%Z) Unknown Deployment Group: $DEPLOYMENT_GROUP_NAME Detected!!! Deployment has Failed!!!" >> $LOG
	#Fail and Exit
	exit 1
fi
