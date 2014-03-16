#!/bin/bash
packer build \
  -var "aws_access_key=`cat .env | grep AWS_ID | sed 's/AWS_ID=//'`" \
  -var "aws_secret_key=`cat .env | grep AWS_KEY | sed 's/AWS_KEY=//'`" \
  -only=aws \
  node_and_ruby_packer.json
