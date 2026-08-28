#!/bin/bash

# It should be empty.

# Compare staged libs against what's currently installed
ldd /sbin/cryptsetup | awk '{print $3}' | grep -v '^$' | while read lib; do
    staged="/usr/src/initramfs$lib"
    if [ -f "$staged" ] && [ -f "$lib" ]; then
        cmp -s "$lib" "$staged" || echo "DRIFTED: $lib"
    fi
done
