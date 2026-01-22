#!/bin/bash

enabled=1   # set to 0 to skip make for debug

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

    #Grub default to new kernel
    grub-mkconfig -o /boot/grub/grub.cfg
    grep -v '^GRUB_DEFAULT=' /etc/default/grub > /tmp/grub.tmp && echo 'GRUB_DEFAULT="'$(grep -i "Gentoo GNU/Linux, with" /boot/grub/grub.cfg | grep -i cachyos | head -n1 | cut -d'"' -f2)'"' >> /tmp/grub.tmp && mv /tmp/grub.tmp /etc/default/grub
else
    echo "Build disabled (enabled=0), skipping make step"
fi
