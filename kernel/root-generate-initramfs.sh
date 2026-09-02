#!/bin/bash

KERNEL="7.2.3-gentoo"

cd /usr/src/initramfs

find . | cpio -o -H newc | gzip > /boot/initramfs-$KERNEL.img

grub-mkconfig -o /boot/grub/grub.cfg
