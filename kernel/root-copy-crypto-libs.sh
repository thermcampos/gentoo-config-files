#!/bin/bash
set -e
cd /usr/src/initramfs

# Re-copy the binaries themselves
cp -v /sbin/cryptsetup /usr/src/initramfs/sbin/
cp -v /sbin/lvm /usr/src/initramfs/sbin/

# Regenerate the list of required libs and copy each one
for bin in /sbin/cryptsetup /sbin/lvm; do
    ldd "$bin" | awk '
        $2 == "=>" && $3 != "" { print $3; next }
        $1 ~ /^\// { print $1 }
    '
done | sort -u | while read -r lib; do
    [ -f "$lib" ] || continue
    dest="/usr/src/initramfs$lib"
    mkdir -p "$(dirname "$dest")"
    cp -v "$lib" "$dest"
done

