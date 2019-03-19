#!/bin/sh
#This must be run as root

pacman-key --init
pacman-key --add wintermute.pub
pacman-key --lsign F7FD5492264BB9D0

echo "
[dkp-libs]
Server = http://downloads.devkitpro.org/packages
" >> /etc/pacman.conf

echo "
[dkp-linux]
Server = http://downloads.devkitpro.org/packages/linux
" >> /etc/pacman.conf

pacman --noconfirm -U https://downloads.devkitpro.org/devkitpro-keyring-r1.787e015-2-any.pkg.tar.xz

pacman --noconfirm -Sy

pacman --noconfirm --needed -S devkit-env

# Hotfix until devkitPro adds this
echo "export WUT_ROOT=/opt/devkitpro/wut" > /etc/profile.d/wut-env
