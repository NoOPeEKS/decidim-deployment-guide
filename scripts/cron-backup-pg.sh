#!/bin/bash

DATE=$(date +%Y%m%d_%H%M%S)

if ! mkdir /tmp/backups; then
    mkdir /tmp/backups
fi

docker exec $(docker ps | grep postgres | awk '{ print $1 }') pg_dump -U youruserhere -d yourdatabasehere > /tmp/backups/dump_$DATE.sql

aws s3 cp /tmp/backups/dump_$DATE.sql s3://your-bucket-name/
