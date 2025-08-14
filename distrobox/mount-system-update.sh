#!/bin/bash
# Clean and create a temporary /system-update mount to satisfy distrobox
# Fix: symlink will point to /tmp on boot which doesnt break the boot sequence since the target does not exist
# /usr/local/bin/mount-system-update.sh
# 1. If /system-update is a symlink, resolve the real path
if [ -L /system-update ]; then
    REAL_PATH=$(readlink -f /system-update)
    # Unmount if mounted
    if mountpoint -q "$REAL_PATH"; then
        sudo umount "$REAL_PATH"
    fi
    sudo rm -f /system-update
fi

# 2. If /system-update is a mountpoint, unmount it
if mountpoint -q /system-update; then
    sudo umount /system-update
fi

# 3. If the directory still exists, remove it
if [ -d /system-update ]; then
    sudo rm -rf /system-update
fi

# 4. Find and unmount any tmpfs mounts under /tmp that may have been left behind
for MOUNT in $(mount | grep '/tmp/tmp.' | awk '{print $3}'); do
    sudo umount "$MOUNT"
done

# 5. Create new temp directory and mount
TMP_SYS_UPDATE=$(mktemp -d)
sudo mount --bind /tmp/wurst "$TMP_SYS_UPDATE"
sudo ln -s "$TMP_SYS_UPDATE" /system-update
