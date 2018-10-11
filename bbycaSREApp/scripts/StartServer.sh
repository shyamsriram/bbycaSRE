#!/bin/sh

STAGING="/var/bbycasre/staging"
DEPLOYPATH="/opt/bbycaSRE/DEV"
ENV="DEV"
PORT="8000"
LOG="/var/log/bbycaSRE.log"

source ~/.bashrc

date +"%d-%b-%Y %H:%M:%S (%Z) ENV: $ENV PORT: $PORT CURDIR:$CURDIR DEPLOYPATH: $DEPLOYPATH DEPLOYMENT GRP: $DEPLOYMENT_GROUP_NAME" >> /var/log/bbycaSRE.log

export ENV=$ENV
export PORT=$PORT

mkdir -p $DEPLOYPATH

cp -prf $STAGING/* $DEPLOYPATH

date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy Node Js Application...!!!" >> $LOG

#Start the Server in background
node $DEPLOYPATH/bbycaSREApp/src/bestbuy.ca.js 1>>$LOG 2>>$LOG &
