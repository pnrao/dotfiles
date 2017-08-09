#!/usr/bin/zsh

pushd /mnt/redsea/AUR

# BOTTOM LEVEL

for i in libsysstat-git libqtxdg-git libfm-qt-git qtermwidget-git liblxqt-git lxqt-globalkeys-git
do
	pushd $i
	rm -rf src/build
	makepkg -isf --asdeps --noconfirm --noprogressbar #--needed
	popd
done

for i in lxqt-themes-git lximage-qt-git qterminal-git lxqt-admin-git lxqt-about-git lxqt-config-git lxqt-notificationd-git lxqt-openssh-askpass-git lxqt-runner-git lxqt-session-git lxqt-sudo-git lxqt-policykit-git lxqt-powermanagement-git lxqt-qtplugin-git pcmanfm-qt-git lxqt-panel-git
do
	pushd $i
	rm -rf src/build
	makepkg -isf --noconfirm --noprogressbar #--needed
	popd
done
