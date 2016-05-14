#!/bin/bash

# What a mess.
sudo -s

# Clobber all the existing system Pythons, and then
# start meandering around /usr/local to clobber whatever
# crud I've left around there.
apt-get remove .*python.*

# http://www.raspberrypi.org/phpBB3/viewtopic.php?f=32&t=15370
# Unfortunately, system Python doesn't play nice with uWSGI,
# so we have to build our own.
# Don't forget libbz2-dev otherwise the get-pip.py will crash
# and burn with "No module named bz2".

apt-get install build-essential libssl-dev libbz2-dev
wget http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
tar xjf Python-2.7.5.tar.bz2
cd Python-2.7.5
./configure --enable-shared --enable-threads; make; make install; ldconfig

#http://raspberry.io/wiki/how-to-get-python-on-your-raspberrypi/
# Once we have a base Python installed, we can get pull distribute,
# and use that to install pip (package manager).

curl -O http://python-distribute.org/distribute_setup.py
python distribute_setup.py
curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py

# If we're going to install virtualenv, we should probably do that now.
#sudo pip install virtualenv # Commented out. We're not using it anyway.

# Now we have a pip registered against our python, we can install
# uWSGI which should hopefully be compiled correctly.
CFLAGS=-I/usr/local/include/python2.7 pip install uwsgi

# May as well do flask now, since that's pretty much the whole shebang done.
pip install flask

# Only thing left is to wrangle python 3.2. But that's much easier.
#apt-get install python3-minimal
