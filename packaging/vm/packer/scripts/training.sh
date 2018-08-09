#!/bin/bash
# Script to toggle training mode
# http://boundlessgeo.com/
# Maintainer- Nick Stires

if [ "$(id -u)" != "0" ]; then
 echo "This script must be run as root" 1>&2
 exit 1
fi

if [ "$1" != "on" ] && [ "$1" != "off" ]; then
 echo "Incorrect arguements provided."
 echo "Proper use is: training.sh on/off"
 exit 1
fi

TRAINING_MODE=$1

function pause(){
 read -p "$*"
}

pkill -9 -U tomcat8

if [ "$TRAINING_MODE" == "on" ]; then
  echo "Enabling training mode..."
  
  if psql -lqt -U postgres | cut -d \| -f 1 | grep -qw training; then
    echo "Training DB found, skipping..."
  else
    echo "Creating training DB..."
    createdb -U postgres training
  fi
  
  psql -U postgres -c 'CREATE EXTENSION postgis;' training
  
  sed -i 's:"/var/opt/boundless/server/geoserver/default-data":"/var/opt/boundless/server/geoserver/data":' /etc/tomcat8/Catalina/localhost/geoserver.xml
  sed -i 's:"/var/opt/boundless/server/geoserver/default-data/global.xml":"/var/opt/boundless/server/geoserver/data/global.xml":' /etc/tomcat8/Catalina/localhost/geoserver.xml
elif [ "$TRAINING_MODE" == "off" ]; then
  if psql -lqt -U postgres | cut -d \| -f 1 | grep -qw training; then
    echo "Training DB found, deleting..."
    dropdb -U postgres training
  else
    echo "No training DB found, skipping..."
  fi
  
  sed -i 's:"/var/opt/boundless/server/geoserver/data":"/var/opt/boundless/server/geoserver/default-data":' /etc/tomcat8/Catalina/localhost/geoserver.xml
  sed -i 's:"/var/opt/boundless/server/geoserver/data/global.xml":"/var/opt/boundless/server/geoserver/default-data/global.xml":' /etc/tomcat8/Catalina/localhost/geoserver.xml
fi

service tomcat8 start
