from mitiab import app
from flask import render_template, request, url_for, redirect, send_file, make_response
import os
import subprocess

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Main view routes
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# We have 3 different types of views atm, but / isn't one of them.
@app.route("/")
def title():
  # system("mount -o ro /dev/sdXXX /mnt/storage")
  files = os.listdir('/mnt/storage')
  files.sort()

  return render_template('firstrun.jhtml', filelist=files)


@app.route("/install/<file>", methods=['POST'])
def install(file):
  subprocess.call("/home/pi/system/mitiab/support/restore-backup.sh " + file, shell=True)
  subprocess.call("systemctl isolate outbreak-running", shell=True)

  return render_template('restoring.jhtml')
