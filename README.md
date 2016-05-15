# mitiab - Medical-IT-in-a-box
A robust system for use in infections disease outbreaks - NHS Hack Day London 2016

## Development

Assumes Raspbian.

You may need to run `setup-pi-python.sh` on a Raspberry Pi to get the right gubbins in the right places.

Having done that, you can then build this package can be be built with `dpkg-buildpackage -rfakeroot -b` and installation is as easy as `dpkg -i mitiab*.deb`.

Hopefully.


# Mitiab Admin App

- Requires Python 2
- pip install gunicorn flask
