# gentoo-config-files

Simple repo to keep Gentoo config files. Just in case.

## Quick Kernel Upgrade Guide

1. Update symlink, if not updated yet
2. cd /usr/src/linux
3. Copy old .config
4. Run `make olddefconfig`
5. Compile with `make -j12`
6. Run ldd drift-check using saved scripts
7. Generate new minimal initramfs and save into /boot
8. Update grub

More at: https://wiki.gentoo.org/wiki/Kernel/Upgrade
