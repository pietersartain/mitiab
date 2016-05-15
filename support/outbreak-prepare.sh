#!/bin/bash

## This is the startup that happens AFTER boot, when the user has selected either to continue
## with a virgin database or to restore a backup from the USB drive

cd "`dirname $0`"/ohc/outbreak

. ../.env/bin/activate
python manage.py migrate
python manage.py collectstatic --noinput

