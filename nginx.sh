#!/bin/bash

set -e
if [[ -z "$1" ]]
then
  echo "Please enter an app name"
  read APP_NAME;
else
  APP_NAME=$1;
fi

if [[ -z "$2" ]]
then
  echo "Please enter an app port"
  read APP_PORT;
else
  APP_PORT=$2;
fi

if [[ -z "$3" ]]
then
  echo "Please enter an app domain name"
  read APP_DOMAIN;
else
  APP_DOMAIN=$3;
fi

NGINX_FILE="/etc/nginx/sites-enabled/$APP_NAME"
sudo sh -c "curl -s http://raw.github.com/juliangiuca/automation_scripts/nginx.conf \
  | sed \"s/APP_NAME/$APP_NAME/\" \
  | sed \"s/APP_PORT/$APP_PORT/\" \
  | sed \"s/APP_DOMAIN/$APP_DOMAIN/\" \
  > $NGINX_FILE"




