#!/bin/bash

cd /usr/src/initramfs

# Re-copy the binaries themselves
cp /sbin/cryptsetup /usr/src/initramfs/sbin/
cp /sbin/lvm /usr/src/initramfs/sbin/

# Regenerate the list of required libs and copy each one
for bin in /sbin/cryptsetup /sbin/lvm; do
    ldd "$bin" | awk '{print $3}' | grep -v '^$'
done | sort -u
