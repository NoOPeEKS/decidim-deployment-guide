#!/bin/bash

aws s3 cp /var/lib/docker/volumes/decidim-tutorial_pg-data s3://your-bucket-name/ --recursive
