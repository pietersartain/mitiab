# __init__.py
import sys

# Check compatibility
if ( sys.version_info > (2, 8) ):
  raise "Requires Python 2.7!"

# Python 2.7 only
# Flask is not compatible with Python 3.2 currently.
from flask import Flask
app = Flask(__name__)
app.debug = True

import mitiab.main
