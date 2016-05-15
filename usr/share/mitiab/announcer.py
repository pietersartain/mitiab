#!/usr/bin/env python3

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
#
# message = bytes("Python caller test", "utf-8")
#
# announcer = Announcer()
# announcer.announce(message)

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
    message = bytes("No message?", "utf-8")

    if len(sys.argv) > 1:
      message = bytes(" ".join(sys.argv[1:]), "utf-8")

    announcer = Announcer()
    announcer.announce(message)
