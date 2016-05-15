#!/usr/bin/env python

# Raspberry Pi setup:
# sudo systemctl stop serial-getty@ttyAMA0.service
# sudo systemctl disable serial-getty@ttyAMA0.service
# sudo nano /boot/cmdline.txt
#     - and remove 'console=serial0,115200 ' from the file

# REQUIREMENTS:
# `easy_install -Z pyserial` or `pip install pyserial`
#
#
# USAGE:
# announcer.py this is a test
# announcer.py "this is a test"
#
#
# USAGE FROM PYTHON:
#
# from announcer import Announcer
# announcer = Announcer()
# announcer.announce("Python caller test")

import serial
import sys

class Announcer(object):
  def __init__(self):
    self.serial = serial.Serial("/dev/ttyAMA0", 9600)
    self.serial.timeout = 5
    self.serial.writeTimeout = 5

  def announce(self, message):
    self.serial.write(message)

################################################################################
if __name__ == "__main__":
    message = "No message?"

    if len(sys.argv) > 1:
      message = " ".join(sys.argv[1:])

    announcer = Announcer()
    announcer.announce(message)
