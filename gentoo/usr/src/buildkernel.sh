#!/bin/bash

enabled=1 

if [ "$1" != "build" ]; then
    echo "Kernel selection verification step"
    sudo eselect kernel list
    echo
    echo "If correct, rerun:"
    echo "  sudo $0 build"
    exit 0
fi

set -e

if [ "$enabled" -eq 1 ]; then
    echo "Starting kernel build..."

    cd /usr/src/linux
    sudo make -j"$(nproc)"
    sudo make modules_install
    sudo make install

    # build and install nvidia modules
    sh /usr/src/nvidia-postinstall/build-modules.sh

# Regenerate grub.cfg so the new kernel shows up
grub-mkconfig -o /boot/grub/grub.cfg

# Pick newest CachyOS kernel entry
TITLE=$(
  grep -i "menuentry 'Gentoo GNU/Linux, with Linux" /boot/grub/grub.cfg |
  grep -i "cachyos" |
  grep -v "recovery mode" |
  sed -n "s/^menuentry '\([^']*\)'.*/\1/p" |
  head -n1
)

[ -z "$TITLE" ] && {
  echo "No CachyOS kernel found, GRUB_DEFAULT unchanged"
  exit 1
}

# Update GRUB_DEFAULT
sed -i "/^GRUB_DEFAULT=/d" /etc/default/grub
echo "GRUB_DEFAULT=\"$TITLE\"" >> /etc/default/grub

# Rebuild grub.cfg with new default
grub-mkconfig -o /boot/grub/grub.cfg


else
    echo "Build disabled (enabled=0), skipping make step"

#  sh /usr/src/nvidia-postinstall/build-modules.sh

fi
