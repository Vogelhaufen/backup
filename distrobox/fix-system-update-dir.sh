#!/bin/bash
#@REBOOT cronjob
#/usr/local/bin/fix-system-update-dir.sh

  #sleep 2

# Set correct ownership and permissions
rm -rf /system-update
sleep 5 && mkdir /system-update &
chmod 755 /system-update
