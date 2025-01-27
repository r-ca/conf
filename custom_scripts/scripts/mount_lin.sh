#!/bin/bash
# Description: Mounts a shared directory via CIFS.
# Usage: mount_kadai.sh <classroom> <user>

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <classroom> <user>"
    exit 1
fi

CLASSROOM=$1
USER=$2
MOUNT_DIR="$HOME/mounts/$USER"

# Create mount directory if it does not exist
mkdir -p "$MOUNT_DIR"

# Check if mount target is reachable
PING_TARGET="172.24.${CLASSROOM}.230"
ping -c 1 -W 2 "$PING_TARGET" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Host $PING_TARGET is unreachable."
    exit 1
fi

# Mount the shared folder
mount -t cifs -o user="$USER",password="$USER",dir_mode=0777,file_mode=0777,rw,domain=WORKGROUP "//${PING_TARGET}/${USER}" "$MOUNT_DIR"

if [ $? -eq 0 ]; then
    echo "Mounted successfully at $MOUNT_DIR."
else
    echo "Failed to mount."
    exit 1
fi
