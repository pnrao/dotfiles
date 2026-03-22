if [ -z $DISPLAY ]; then
	export EDITOR=emacs
else
	export EDITOR=subl
fi

export LESS="-i -R"
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'

export XDG_CONFIG_HOME=$HOME/.config

export PATH=$HOME/.local/bin:$HOME/bin:$PATH:$HOME/node_modules/.bin:$HOME/.cache/.bun/bin

export XKB_DEFAULT_MODEL=pc104

export XKB_DEFAULT_LAYOUT=us

export XKB_DEFAULT_VARIANT=altgr-intl

export XKB_DEFAULT_OPTIONS="lv3:ralt_alt,caps:super,lv3:lwin_switch"

export _JAVA_AWT_WM_NONREPARENTING=1

export PYTHONSTARTUP=$HOME/.pystartup

export ANDROID_HOME=/opt/android

export NODE_REPL_HISTORY_FILE=~/.node_history

export ERL_AFLAGS="-kernel shell_history enabled"

export WINEDEBUG=-all

export IMDB_RENAME_DATA_DIR=~/.cache/imdb-rename

pgrep -u $(id -u) ssh-agent > /dev/null || (eval $(ssh-agent) && ssh-add)

export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$HOME/.elan/bin"
export PATH="$PATH:$HOME/src/flutter/bin"
export CHROME_EXECUTABLE="/usr/bin/brave-browser"

export GUIX_PROFILE="$HOME/.config/guix/current"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"

export PATH="$PATH:${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
