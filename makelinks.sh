#!/usr/bin/zsh
thisdir=$0:a:h

# No rm here. Delete stuff manually
ln -s $thisdir/Xresources ~/.Xresources
ln -s $thisdir/aliases ~/.aliases
ln -s $thisdir/bashrc ~/.bashrc
ln -s $thisdir/conkyrc ~/.conkyrc
mkdir -p ~/.emacs.d
ln -s $thisdir/init.el ~/.config/emacs/init.el
ln -s $thisdir/profile ~/.profile
ln -s $thisdir/profile ~/.zprofile
ln -s $thisdir/pystartup ~/.pystartup
ln -s $thisdir/vimrc ~/.vimrc
ln -s $thisdir/xbindkeysrc ~/.xbindkeysrc
ln -s $thisdir/zshrc ~/.zshrc
ln -s $thisdir/tmux.conf ~/.tmux.conf
ln -s $thisdir/awesome ~/.config/awesome
mkdir -p ~/.ssh/tmp
ln -s $thisdir/ssh_config ~/.ssh/config
gcc -Wall -O3 -fdata-sections -ffunction-sections -Wl,--gc-sections $thisdir/bin/bgcolor.c -o $thisdir/bin/bgcolor

mkdir -p ~/.config/openbox
ln -s $thisdir/config/openbox/rc.xml ~/.config/openbox/rc.xml

mkdir -p ~/.config/sway
ln -s $thisdir/config/sway/config ~/.config/sway/config
