#!/bin/bash

# Full resolved absolute path (follows every link in the chain)
target=$(readlink -f /usr/src/linux)        # /usr/src/linux-7.2.10-gentoo

# Just the version part
# 7.2.10-gentoo
TARGET_KERNEL=$(echo $target | cut -d'-' -f2)

echo "Generating initramfs for kernel $TARGET_KERNEL-gentoo" 
cd /usr/src/initramfs
find . | cpio -o -H newc | gzip > /boot/initramfs-$TARGET_KERNEL-gentoo.img
echo "Generated initramfs"

echo "Updating grub"
grub-mkconfig -o /boot/grub/grub.cfg
echo "Done"
