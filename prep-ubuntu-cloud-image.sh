#!/bin/bash

IMAGES=./images
BASE=xenial-server-cloudimg-amd64-disk1.img
NEW=xenial-server-cloudimg-amd64-prep.img
MNT=/mnt/images

cd $IMAGES
cp $BASE $NEW

sudo modprobe nbd max_part=16
sudo qemu-nbd -c /dev/nbd0 $NEW
sudo partprobe /dev/nbd0
sudo mkdir -p $MNT
sudo mount /dev/nbd0p1 $MNT
sudo sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' $MNT/etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' $MNT/etc/ssh/sshd_config
sudo chroot $MNT sh -c 'echo "root:passwd" | /usr/sbin/chpasswd'
sudo umount $MNT
sudo qemu-nbd -d /dev/nbd0
md5sum $NEW > $NEW.md5sum
