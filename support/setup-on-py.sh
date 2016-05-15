#!/bin/bash
set -e

## This is the initialisation stage, that happens as we set up the Pi
cd "`dirname $0`"

apt-get update
apt-get install -y python-virtualenv python-dev libpq-dev libffi-dev git postgresql-9.4
su postgres -c 'psql -c "drop database outbreak;" || true'
su postgres -c 'psql -c "drop role outbreak;" || true'
su postgres -c 'psql -c "create role outbreak with password '\''caiZuo6u'\'';"'
su postgres -c 'psql -c "create database outbreak with owner outbreak;"'
mkdir -p ohc
cd ohc
rm ./outbreak ./.env -rf
git clone https://github.com/nhshackday/outbreak
virtualenv .env
. .env/bin/activate
cd outbreak/
pip install -r requirements.txt

