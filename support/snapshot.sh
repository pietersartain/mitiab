#!/bin/bash

# Naming
# snapshot-143-ab25f033-2015.02.01-15.43.22.sql.gz

# 	143 is the snapshot number - it starts counting from the largest snapshot number available on storage.
# 	ab24f033 is a truncated SHA256 hash of the contents of the file (for integrity checking and duplicate identification)

# 	2015.02.01-15.43.22 is a timestamp indicating when this snapshot was taken (according to the clock at the time.
# 		Thanks to the vagaries of Raspberry Pis and generally systems that haven’t seen the internet in a while,
# 		this timestamp is highly unreliable)

device=/dev/sda1
db=outbreak

if [ ! -d /mnt/storage ]; then
	mkdir /mnt/storage
fi

su postgres -c "pg_dump -d outbreak" > /tmp/db_dump
sha256hash=$(sha256sum /tmp/db_dump | awk '{print $1}')
idx=$(cat /etc/snapshot_idx)
idx=$((idx+1))

mount -o remount,rw /mnt/storage

cp /tmp/db_dump /mnt/storage/snapshot-$idx-$sha256hash-$(date +%F-%R).sql && \
	sync &&
	mount -o remount,ro /mnt/storage

status=$?
if [[ $status = 0 ]]; then
	echo Backup OK
	# /home/pi/ohc/mitiab/usr/share/mitiab/announcer.py Backup OK
else
	echo Backup Failed
	# /home/pi/ohc/mitiab/usr/share/mitiab/announcer.py Backup Failed
	# Stop the world.
fi
echo ${idx} > /etc/snapshot_idx
