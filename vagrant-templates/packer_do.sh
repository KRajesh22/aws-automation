#!/bin/bash
packer build \
  -var "do_client_id=`cat .env | grep DO_CLIENT_ID | sed 's/DO_CLIENT_ID=//'`" \
  -var "do_api_key=`cat .env | grep DO_API_KEY | sed 's/DO_API_KEY=//'`" \
  -only=digitalocean \
  node_and_ruby_packer.json
