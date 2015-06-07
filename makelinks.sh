#!/usr/bin/zsh
thisdir=$0:a:h

# No rm here. Delete stuff manually
ln -s $thisdir/Xresources ~/.Xresources
ln -s $thisdir/aliases ~/.aliases
ln -s $thisdir/bashrc ~/.bashrc
ln -s $thisdir/conkyrc ~/.conkyrc
mkdir -p ~/.emacs.d
ln -s $thisdir/init.el ~/.emacs.d/init.el
ln -s $thisdir/profile ~/.profile
ln -s $thisdir/profile ~/.zprofile
ln -s $thisdir/pystartup ~/.pystartup
ln -s $thisdir/vimrc ~/.vimrc
ln -s $thisdir/xbindkeysrc ~/.xbindkeysrc
ln -s $thisdir/zshrc ~/.zshrc
ln -s $thisdir/Xdefaukts ~/.Xdefaults
ln -s $thisdir/tmux.conf ~/.tmux.conf
ln -s $thisdir/awesome ~/.config/awesome
ln -s $thisdir/bin/startup.sh ~/bin/startup.sh
ln -s $thisdir/bin/fan-off ~/bin/
ln -s $thisdir/bin/context ~/bin/
ln -s $thisdir/bin/mtxrun ~/bin/
ln -s $thisdir/bin/bibtex ~/bin/
ln -s $thisdir/bin/sd-photos ~/bin/
ln -s $thisdir/bin/network-gui ~/bin/
mkdir -p ~/.ssh/tmp
ln -s $thisdir/ssh_config ~/.ssh/config
gcc -Wall -O3 -fdata-sections -ffunction-sections -Wl,--gc-sections $thisdir/bin/bgcolor.c -o ~/bin/bgcolor

mkdir -p ~/.config/openbox
ln -s $thisdir/config/openbox/rc.xml ~/.config/openbox/rc.xml
