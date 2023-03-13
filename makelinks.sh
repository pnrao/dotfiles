#!/usr/bin/zsh
thisdir=$0:a:h

ln -sf $thisdir/Xresources ~/.Xresources
ln -sf $thisdir/aliases ~/.aliases
ln -sf $thisdir/bashrc ~/.bashrc
ln -sf $thisdir/conkyrc ~/.conkyrc
mkdir -p ~/.emacs.d
ln -sf $thisdir/init.el ~/.config/emacs/init.el
ln -sf $thisdir/init.el ~/.emacs
ln -sf $thisdir/profile ~/.profile
ln -sf $thisdir/profile ~/.zprofile
ln -sf $thisdir/pystartup ~/.pystartup
ln -sf $thisdir/vimrc ~/.vimrc
ln -sf $thisdir/xbindkeysrc ~/.xbindkeysrc
ln -sf $thisdir/zshrc ~/.zshrc
ln -sf $thisdir/tmux.conf ~/.tmux.conf
ln -sf $thisdir/awesome ~/.config/awesome
mkdir -p ~/.ssh/tmp
ln -sf $thisdir/ssh_config ~/.ssh/config
gcc -Wall -O3 -fdata-sections -ffunction-sections -Wl,--gc-sections $thisdir/bin/bgcolor.c -o $HOME/bin/bgcolor

mkdir -p ~/.config/openbox
ln -sf $thisdir/config/openbox/rc.xml ~/.config/openbox/rc.xml

mkdir -p ~/.config/sway
ln -sf $thisdir/config/sway/config ~/.config/sway/config
