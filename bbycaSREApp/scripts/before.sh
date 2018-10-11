#!/bin/sh

date +"%d-%b-%Y %H:%M:%S (%Z) AWS Deployment Started...." > /var/log/bbycaSRE.log

#Clean Up any Previous Deployments
rm -rf /var/bbycasre 
