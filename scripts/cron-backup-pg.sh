#!/bin/bash

# Source folder path
SOURCE_DIR="/var/lib/docker/volumes/yourpgvolumename/"

# Destiny folder path
DESTINATION_DIR="/var/backups/yourpgvolumename"

# Copy only files and directories that have changed using rsync
rsync -av "$SOURCE_DIR" "$DESTINATION_DIR"
