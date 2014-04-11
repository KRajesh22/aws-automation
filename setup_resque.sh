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
  echo "Please enter the user to run the service";
  read APP_USER;
else
  APP_USER=$2;
fi


if [ -z "$3" ]
then
  echo "Please enter the user to run the service";
  read APP_WORKER_COUNT;
else
  APP_WORKER_COUNT=$3;
fi

RESQUE_WORKER_FILE="/etc/init/$APP_NAME-resque"
sudo sh -c "curl -s -L https://raw.github.com/juliangiuca/aws_automation/master/init/resque.conf \
  | sed \"s/APP_NAME/$APP_NAME/g\" \
  | sed \"s/APP_USER/$APP_USER/g\" \
  | sed \"s/APP_WORKER_COUNT/$APP_WORKER_COUNT/g\" \
  > $RESQUE_WORKER_FILE"

RESQUE_WORKER_FILE="/etc/init/$APP_NAME-resque-worker"
sudo sh -c "curl -s -L https://raw.github.com/juliangiuca/aws_automation/master/init/resque-worker.conf \
  | sed \"s/APP_NAME/$APP_NAME/g\" \
  | sed \"s/APP_USER/$APP_USER/g\" \
  | sed \"s/APP_WORKER_COUNT/$APP_WORKER_COUNT/g\" \
  > $RESQUE_WORKER_FILE"
