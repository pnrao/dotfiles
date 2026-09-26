#!/usr/bin/zsh
thisdir=$0:a:h

ln -sf $thisdir/Xresources ~/.Xresources
ln -sf $thisdir/aliases ~/.aliases
ln -sf $thisdir/bashrc ~/.bashrc
mkdir -p ~/.emacs.d
ln -sf $thisdir/init.el ~/.config/emacs/init.el
ln -sf $thisdir/init.el ~/.emacs
ln -sf $thisdir/profile ~/.bash_profile
ln -sf $thisdir/profile ~/.zprofile
ln -sf $thisdir/pystartup ~/.pystartup
ln -sf $thisdir/vimrc ~/.vimrc
ln -sf $thisdir/zshrc ~/.zshrc
ln -sf $thisdir/tmux.conf ~/.tmux.conf
mkdir -p ~/.ssh/tmp
ln -sf $thisdir/ssh_config ~/.ssh/config
gcc -Wall -Wextra -O3 -std=gnu17 -fdata-sections -ffunction-sections -Wl,--gc-sections $thisdir/bin/bgcolor.c -o $HOME/bin/bgcolor
ln -sf $thisdir/bin/start-menu.sh ~/bin/start-menu

mkdir -p ~/.config/openbox
ln -sf $thisdir/config/openbox/rc.xml ~/.config/openbox/rc.xml

ln -sfT $thisdir/config/wezterm ~/.config/wezterm
ln -sfT $thisdir/config/labwc ~/.config/labwc
ln -sf $thisdir/w3m_config ~/.w3m/config

ln -sfT $thisdir/config/hypr ~/.config/hypr
ln -sfT $thisdir/config/waybar ~/.config/waybar
ln -sfT $thisdir/config/quickshell ~/.config/quickshell
ln -sfT $thisdir/config/wofi ~/.config/wofi
ln -sfT $thisdir/config/mako ~/.config/mako
ln -sfT $thisdir/config/espanso ~/.config/espanso
