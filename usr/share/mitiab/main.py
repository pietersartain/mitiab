from mitiab import app
from flask import render_template, request, url_for, redirect, send_file, make_response
import os

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Main view routes
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# We have 3 different types of views atm, but / isn't one of them.
@app.route("/")
def title():
  # system("mount -o ro /dev/sdXXX /mnt/storage")
  return render_template('firstrun.jhtml', filelist=os.listdir('/mnt/storage').sort())


@app.route("/install/<file>")
def install(file):
  system("su postgres -c psql outbreak < /mnt/storage/" + file)
  system("systemctl isolate outbreak-running")
