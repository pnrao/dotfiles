#!/usr/bin/dash

find /etc /opt /usr | sort > /tmp/all_files.txt
pacman -Qlq | sed 's|/$||' | sort > /tmp/owned_files.txt
comm -23 /tmp/all_files.txt /tmp/owned_files.txt