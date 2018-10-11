#!/bin/sh

date +"%d-%b-%Y %H:%M:%S (%Z) Stopping Best Buy Node JS Application...." >> /var/log/bbycaSRE.log
#Stop the Server
killall node
