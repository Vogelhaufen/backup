#!/bin/bash
# /usr/local/bin/fix-vboxusb-perms.sh
# /etc/systemd/system/fix-vboxusb-perms.service
# [Unit]
# Description=Fix VirtualBox USB permissions for rootless containers
# After=vboxdrv.service
# Wants=vboxdrv.service

# [Service]
# Type=oneshot
# ExecStart=/usr/local/bin/fix-vboxusb-perms.sh
# RemainAfterExit=yes

# [Install]
# WantedBy=multi-user.target

# Fix permissions on VirtualBox USB devices so rootless containers can access them
chmod -R 755 /dev/vboxusb
