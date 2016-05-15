#!/bin/bash
# Reloading from a backup
set -e

if [ "$1" == "" ]; then
	echo "Usage: $0 <backup.sql>"
	exit 1
fi

su postgres -c 'psql -c "DROP DATABASE outbreak;"' || true
su postgres -c 'psql -c "CREATE DATABASE outbreak WITH OWNER outbreak;"'
su postgres -c 'psql outbreak' < "$1"

