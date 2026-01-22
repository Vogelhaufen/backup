#!/bin/bash

# use current kernel
KERNEL_USE=$(basename "$(readlink /usr/src/linux)")  # get symlink target
KERNEL_USE=${KERNEL_USE#linux-}                     # strip 'linux-' prefix
echo $KERNEL_USE

# static $KERNEL_USE
# overrides automatic detection since its topdown
# uncomment to use:
#KERNEL_USE=<kernel-name> #uname -r




#NVIDIA_SRC=/usr/src/nvidia-570.195.03
NVIDIA_SRC=/usr/src/nvidia-590.48.01


cd $NVIDIA_SRC
make clean
make -j$(nproc) \
 KERNEL_UNAME=$KERNEL_USE \
  SYSSRC="/usr/src/linux-$KERNEL_USE" \
  modules

make modules_install \
  KERNEL_UNAME=$KERNEL_USE \
  SYSSRC="/usr/src/linux-$KERNEL_USE"

depmod $KERNEL_USE

dracut --force
