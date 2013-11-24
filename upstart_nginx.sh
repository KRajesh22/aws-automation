#!/bin/bash

set -e

if [ -z "$1" ]
then
  echo "Please enter an app name"
  read APP_NAME;
else
  APP_NAME=$1;
fi

if [ -z "$2" ]
then
  echo "Please enter an app port"
  read APP_PORT;
else
  APP_PORT=$2;
fi

if [ -z "$3" ]
then
  echo "Please enter an app domain name"
  read APP_DOMAIN;
else
  APP_DOMAIN=$3;
fi

if [ -z "$4" ]
then
  echo "Please enter the user to run the service";
  read APP_USER;
else
  APP_USER=$4;
fi

if [ -z "$5" ]
then
  echo "Node or Unicorn?"
  read APP_TYPE;
else
  APP_TYPE=$5;
fi

AUTHOR=`whoami`


sudo mkdir -p /data/$APP_NAME
sudo chown -R $APP_USER /data/$APP_NAME

NGINX_FILE="/etc/nginx/sites-enabled/$APP_NAME"
sudo sh -c "curl -s https://raw.github.com/juliangiuca/aws_automation/master/conf/nginx.conf \
  | sed \"s/APP_NAME/$APP_NAME/g\" \
  | sed \"s/APP_PORT/$APP_PORT/g\" \
  | sed \"s/APP_DOMAIN/$APP_DOMAIN/g\" \
  > $NGINX_FILE"

UPSTART_FILE="/etc/init/$APP_NAME.conf"
sudo sh -c "curl -s https://raw.github.com/juliangiuca/aws_automation/master/conf/upstart_$APP_TYPE.conf \
  | sed \"s/APP_NAME/$APP_NAME/g\" \
  | sed \"s/APP_PORT/$APP_PORT/g\" \
  | sed \"s/AUTHOR/$AUTHOR/g\" \
  | sed \"s/APP_USER/$APP_USER/g\" \
  > $UPSTART_FILE"



