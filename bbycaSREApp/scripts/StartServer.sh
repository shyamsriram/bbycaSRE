#!/bin/sh

STAGING="/var/bbycasre/staging/"
DEPLOYPATH="/opt/bbycaSREApp/DEV"
ENV="DEV"
PORT="8000"
LOG="/var/log/bbycaSRE.log/var/log/bbycaSRE.log"

date +"%d-%b-%Y %H:%M:%S (%Z) ENV: $ENV PORT: $PORT CURDIR:$CURDIR DEPLOYPATH: $DEPLOYPATH DEPLOYMENT GRP: $DEPLOYMENT_GROUP_NAME" >> /var/log/bbycaSRE.log

export ENV=$ENV
export PORT=$PORT

mkdir -p $DEPLOYPATH

cp -prf $STAGING/../* $DEPLOYPATH

date +"%d-%b-%Y %H:%M:%S (%Z) Starting Best Buy Node Js Application...!!!" >> /var/log/bbycaSRE.log

#Start the Server in background
node $DEPLOYPATH/src/bestbuy.ca.js &
