#!/bin/bash
# Clean and create a temporary /system-update mount to satisfy distrobox
# Fix: symlink will point to /tmp on boot which doesnt break the boot sequence since the target does not exist
# /usr/local/bin/mount-system-update.sh

# Clean and create a temporary /system-update mount

# Force remove any existing /system-update first
sudo rm -rf /system-update

# Ensure /tmp/wurst exists
if [ ! -d /tmp/wurst ]; then
    mkdir -p /tmp/wurst
fi

# 4. Find and unmount any tmpfs mounts under /tmp that may have been left behind
for MOUNT in $(mount | grep '/tmp/tmp.' | awk '{print $3}'); do
    sudo umount "$MOUNT"
done

# 5. Create new temp directory and mount
TMP_SYS_UPDATE=$(mktemp -d)
sudo mount --bind /tmp/wurst "$TMP_SYS_UPDATE"
sudo ln -s "$TMP_SYS_UPDATE" /system-update
