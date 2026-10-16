#!/usr/bin/zsh
thisdir=$0:a:h

ln -sf $thisdir/Xresources ~/.Xresources
ln -sf $thisdir/aliases ~/.aliases
# Omarchy: bashrc sources Omarchy's env/rc itself, so replacing ~/.bashrc is safe
ln -sf $thisdir/bashrc ~/.bashrc
mkdir -p ~/.local/bin ~/.config/emacs ~/.w3m
ln -sf $thisdir/init.el ~/.config/emacs/init.el
ln -sf $thisdir/init.el ~/.emacs
# Omarchy: profile sources ~/.bashrc itself for bash login shells, so replacing ~/.bash_profile is safe
ln -sf $thisdir/profile ~/.bash_profile
ln -sf $thisdir/profile ~/.zprofile
ln -sf $thisdir/pystartup ~/.pystartup
ln -sf $thisdir/vimrc ~/.vimrc
ln -sf $thisdir/zshrc ~/.zshrc
ln -sf $thisdir/tmux.conf ~/.tmux.conf
mkdir -p ~/.ssh/tmp
chmod 700 ~/.ssh
ln -sf $thisdir/ssh_config ~/.ssh/config
gcc -Wall -Wextra -O3 -std=gnu17 -static -fdata-sections -ffunction-sections -Wl,--gc-sections $thisdir/bin/bgcolor.c -o $HOME/.local/bin/bgcolor
ln -sf $thisdir/bin/start-menu.sh ~/.local/bin/start-menu
ln -sf $thisdir/bin/typdiff-rev ~/.local/bin/typdiff-rev
ln -sf $thisdir/bin/typdiff-watch ~/.local/bin/typdiff-watch

mkdir -p ~/.config/openbox
ln -sf $thisdir/config/openbox/rc.xml ~/.config/openbox/rc.xml

ln -sfT $thisdir/config/wezterm ~/.config/wezterm
ln -sfT $thisdir/config/labwc ~/.config/labwc
ln -sf $thisdir/w3m_config ~/.w3m/config

ln -sfT $thisdir/config/espanso ~/.config/espanso
ln -sfT $thisdir/config/speech-dispatcher ~/.config/speech-dispatcher
mkdir -p ~/.config/systemd/user
ln -sf $thisdir/config/speech-dispatcher/kitten.{socket,service} ~/.config/systemd/user/

if [ -d /usr/share/omarchy ]; then
    # Hyprland Lua overrides (loaded after Omarchy's defaults); a directory link
    # so Omarchy's own edits (e.g. monitor scaling) land in the repo too
    if [ -d ~/.config/hypr ] && [ ! -L ~/.config/hypr ]; then
        mv ~/.config/hypr ~/.config/hypr.orig-$(date +%s)
    fi
    ln -sfT $thisdir/config/hypr ~/.config/hypr

    # Shell settings (bar layout, enabled plugins, idle) and menu extensions;
    # the shell writes through the symlink, so bar changes land in the repo
    mkdir -p ~/.config/omarchy/plugins ~/.config/omarchy/extensions
    ln -sf $thisdir/config/omarchy/shell.json ~/.config/omarchy/shell.json
    ln -sf $thisdir/config/omarchy/extensions/omarchy-menu.jsonc ~/.config/omarchy/extensions/omarchy-menu.jsonc

    # Clone of the built-in notifications plugin, showing up to 10 body lines
    # instead of 3 so multi-line WhatsApp Web messages aren't cut off
    ln -sfT $thisdir/config/omarchy/plugins/pnr.notifications ~/.config/omarchy/plugins/pnr.notifications
    # Clone of the built-in clock: vertical label shows the date in the theme accent above the time
    ln -sfT $thisdir/config/omarchy/plugins/pnr.clock ~/.config/omarchy/plugins/pnr.clock
    # Bar widget: open windows as app icons grouped by workspace, click to focus
    ln -sfT $thisdir/config/omarchy/plugins/pnr.windows ~/.config/omarchy/plugins/pnr.windows

    # Plugin changes (the notifications service especially) need a full restart
    if pgrep -f /usr/share/omarchy/shell >/dev/null; then
        omarchy restart shell
    fi
fi

# Brave only uses speech-dispatcher voices with the first flag; the second shows
# Speedreader's read-aloud button (on by default only from late 2026)
# --test-type hides the "unsupported command-line flag" infobar the first one causes
if [ -f /usr/share/applications/brave-browser.desktop ]; then
    mkdir -p ~/.local/share/applications
    sed 's|^Exec=\(/usr/bin/\)\{0,1\}brave[-a-z]*|& --enable-speech-dispatcher --test-type --enable-features=Speedreader:tts/true|' \
        /usr/share/applications/brave-browser.desktop >~/.local/share/applications/brave-browser.desktop
fi
