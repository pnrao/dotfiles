#!/usr/bin/zsh

pushd /mnt/redsea/AUR

# BOTTOM LEVEL

for i in lxqt-build-tools-git libsysstat-git libqtxdg-git libfm-qt-git liblxqt-git lxqt-globalkeys-git lxqt_wallet-git
do
	pushd $i
	git pull
	rm -rf src/build
	makepkg -isf --asdeps --noprogressbar --noconfirm #--needed
	popd
done

for i in lxqt-archiver-git lxqt-themes-git lximage-qt-git lxqt-admin-git lxqt-about-git lxqt-config-git lxqt-notificationd-git lxqt-openssh-askpass-git lxqt-runner-git lxqt-session-git lxqt-sudo-git lxqt-policykit-git lxqt-powermanagement-git lxqt-qtplugin-git pcmanfm-qt-git lxqt-panel-git lxqt-desktop-git lxqt-kcm-integration-git lxqt-kcm-integration-extra-git lxqt-kwin-desktop-git lxqt-less-theme-git lxqt-desktop-git
do
	pushd $i
	git pull
	rm -rf src/build
	makepkg -isf --noprogressbar --noconfirm #--needed
	popd
done
