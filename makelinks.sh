#!/usr/bin/zsh
thisdir=$0:a:h

# No rm here. Delete stuff manually
ln -s $thisdir/Xresources ~/.Xresources
ln -s $thisdir/aliases ~/.aliases
ln -s $thisdir/bashrc ~/.bashrc
ln -s $thisdir/conkyrc ~/.conkyrc
ln -s $thisdir/emacs ~/.emacs
ln -s $thisdir/profile ~/.profile
ln -s $thisdir/profile ~/.zprofile
ln -s $thisdir/pystartup ~/.pystartup
ln -s $thisdir/vimrc ~/.vimrc
ln -s $thisdir/xbindkeysrc ~/.xbindkeysrc
ln -s $thisdir/zshrc ~/.zshrc
ln -s $thisdir/Xdefaukts ~/.Xdefaults
ln -s $thisdir/awesome ~/.config/awesome
ln -s $thisdir/bin/startup.sh ~/bin/startup.sh
