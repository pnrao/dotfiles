if [ -z $DISPLAY ]; then
	export EDITOR=emacs
else
	export EDITOR=subl3
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

export GOPATH=$HOME/.local/go

export PATH=$HOME/.local/bin:$HOME/bin:$PATH:$GOPATH/bin

export XKB_DEFAULT_MODEL=pc104

export XKB_DEFAULT_LAYOUT=us

export XKB_DEFAULT_VARIANT=altgr-intl

export XKB_DEFAULT_OPTIONS="lv3:ralt_alt,caps:super,lv3:lwin_switch"

export _JAVA_AWT_WM_NONREPARENTING=1

export PYTHONSTARTUP=$HOME/.pystartup

export PYMACS_PYTHON=python2

# source /opt/context-minimals/setuptex
export ANALYSIS_PATH=$HOME/src/analysis

export ANDROID_HOME=/opt/android-sdk

export NODE_REPL_HISTORY_FILE=~/.node_history

export WLC_REPEAT_DELAY=250

export WLC_REPEAT_RATE=30

# [ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

pgrep -u $(id -u) ssh-agent > /dev/null || (eval $(ssh-agent) && ssh-add)
