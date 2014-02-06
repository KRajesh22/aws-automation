#!/bin/bash

set -e

echo "installing libs"
# Install required libraries for RVM and Ruby
sudo apt-get install -yq git
sudo apt-get -y -q install curl wget vim
sudo apt-get -y -q install gawk libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev libxml2-dev libxslt-dev libxml2

# Redis
echo "Installing Redis"
sudo apt-get -y -q install redis-server

#echo "Install Postgresql"
#sudo apt-get -y -q install postgresql libpq-dev postgresql-contrib

# Set Password to test for user postgres
#sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'test';"

echo "Adding add-apt-repository"
# Node.js Setup
sudo apt-get install -y python-software-properties python g++ make
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo add-apt-repository -y ppa:nginx/stable
sudo apt-get update

echo "Installing nginx"
sudo apt-get -y -q install nginx
sudo rm /etc/nginx/sites-enabled/default

echo "Installing NodeJS"
sudo apt-get -y -q install nodejs

\curl -L https://get.rvm.io | sudo bash -s stable --ruby=ruby-2.0.0-p353 --gems=bundler
sudo usermod -a -G rvm `whoami`
source /etc/profile.d/rvm.sh
