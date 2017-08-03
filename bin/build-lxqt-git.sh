#!/usr/bin/zsh

pushd /mnt/redsea/AUR/lxqt-build-tools-git

# INDEPENDENT
cd ../lxqt-themes-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lximage-qt-git
makepkg -is --noconfirm --needed --noprogressbar

# BOTTOM LEVEL
cd ../libsysstat-git
makepkg -is --asdeps --noconfirm --needed --noprogressbar
cd ../lxqt-build-tools-git
makepkg -is --asdeps --noconfirm --needed --noprogressbar
cd ../libqtxdg-git
makepkg -is --asdeps --noconfirm --needed --noprogressbar
cd ../libfm-qt-git
makepkg -is --asdeps --noconfirm --needed --noprogressbar
cd ../qtermwidget-git
makepkg -is --asdeps --noconfirm --needed --noprogressbar

# MID LEVEL
cd ../liblxqt-git
makepkg -is --asdeps --noconfirm --needed --noprogressbar
cd ../lxqt-globalkeys-git
makepkg -is --asdeps --noconfirm --needed --noprogressbar

# TOP LEVEL
cd ../qterminal-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-admin-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-about-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-config-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-notificationd-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-openssh-askpass-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-runner-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-session-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-sudo-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-policykit-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-powermanagement-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-qtplugin-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-pcmanfm-git
makepkg -is --noconfirm --needed --noprogressbar
cd ../lxqt-panel-git
makepkg -is --noconfirm --needed --noprogressbar
