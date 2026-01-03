#!/bin/bash

if [ "$1" != "build" ]; then
    echo "Kernel selection verification step"
    sudo eselect kernel list
    echo
    echo "If correct, rerun:"
    echo "  sudo $0 build"
    exit 0
fi

set -e

cd /usr/src/linux
sudo make -j$(nproc)
sudo make modules_install
sudo make install

# already invoked
#grub-mkconfig -o /boot/grub/grub.cfg

# build and install nvidia modules for current symlink for /usr/src/linux
sh /usr/src/nvidia-postinstall/build-modules.sh
