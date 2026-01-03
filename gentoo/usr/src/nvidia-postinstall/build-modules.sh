#!/bin/bash

# use current kernel
KERNEL_USE=$(basename "$(readlink /usr/src/linux)")  # get symlink target
KERNEL_USE=${KERNEL_USE#linux-}                     # strip 'linux-' prefix

# static $KERNEL_USE
# uncomment to use
# overrides automatic detection since its topdown

#KERNEL_USE=<kernel-name> #uname -r

NVIDIA_SRC=/usr/src/nvidia-570.195.03

cd $NVIDIA_SRC
make clean
make -j$(nproc) \
 # KERNEL_UNAME=$KERNEL_USE \
  SYSSRC="/usr/src/linux-$KERNEL_USE" \
  modules

make modules_install \
  #KERNEL_UNAME=$KERNEL_USE \
  SYSSRC="/usr/src/linux-$KERNEL_USE"

depmod $KERNEL_USE

dracut --force

