#!/usr/bin/zsh

dirs=(/etc /opt /usr)

if [[ -n $@ ]] {
	   dirs=($@)
   }

find $dirs | sort > /tmp/all_files.txt

if command -v pacman &> /dev/null; then
    # Arch Linux
    pacman -Qlq | sed 's|/$||' | sort > /tmp/owned_files.txt
elif command -v dpkg &> /dev/null; then
    # Ubuntu (or other Debian-based)
    dpkg-query -L $(dpkg-query -f '${Package}\n' -W) | sed 's|/$||' | sort > /tmp/owned_files.txt
else
    echo "Unsupported package manager. This script supports pacman (Arch) and dpkg (Ubuntu/Debian)." >&2
    exit 1
fi

comm -23 /tmp/all_files.txt /tmp/owned_files.txt > /tmp/orphan_files.txt
