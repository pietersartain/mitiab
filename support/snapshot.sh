#!/bin/bash

# Naming
# snapshot-143-ab25f033-2015.02.01-15.43.22.sql.gz

# 	143 is the snapshot number - it starts counting from the largest snapshot number available on storage.
# 	ab24f033 is a truncated SHA256 hash of the contents of the file (for integrity checking and duplicate identification)

# 	2015.02.01-15.43.22 is a timestamp indicating when this snapshot was taken (according to the clock at the time. 
# 		Thanks to the vagaries of Raspberry Pis and generally systems that haven’t seen the internet in a while, 
# 		this timestamp is highly unreliable)

device=/dev/sdXXX

pg_dump dbname > /tmp/db_dump
sha256hash=$(sha256sum /tmp/db_dump)

mount $device /mnt/storage && \
cp /tmp/db_dump /mnt/storage/snapshot-$(ls | head -n 1 | awk -F'-' '{print 2}')-$sha256hash-$(date +%F-%R).sql
 && \
umount $device

status=$?
if [[ $status != 0 ]]; then
	# Stop the world.
fi
