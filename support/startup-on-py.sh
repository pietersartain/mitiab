#!/bin/bash

## This is the startup that happens AFTER boot, when the user has selected either to continue
## with a virgin database or to restore a backup from the USB drive

python manage.py migrate
python manage.py collectstatic --noinput
supervisord -c etc/pi.conf

