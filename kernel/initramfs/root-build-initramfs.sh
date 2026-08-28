#!/bin/sh
set -e
STAGE="${1:-/usr/src/initramfs}"

mkdir -p "$STAGE"/{bin,sbin,lib,dev,proc,sys,mnt/root,run}

cp /sbin/busybox "$STAGE/bin/"
"$STAGE/bin/busybox" --install -s "$STAGE/bin"

cp /sbin/cryptsetup "$STAGE/sbin/"
cp /sbin/lvm "$STAGE/sbin/"

for bin in /sbin/cryptsetup /sbin/lvm; do
    ldd "$bin" | awk '{print $3}' | grep -v '^$'
done | sort -u | while read -r lib; do
    mkdir -p "$STAGE$(dirname "$lib")"
    cp -L "$lib" "$STAGE$lib"
done

cp init "$STAGE/init"
chmod +x "$STAGE/init"

echo "Staged tree ready at $STAGE — cd there and run the cpio|gzip packaging step."
