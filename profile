if [ -z $DISPLAY ]; then
	export EDITOR=emacs
else
	export EDITOR=subl
	[ x"$XDG_CURRENT_DESKTOP" = x"KDE" ] || [ x"$XDG_CURRENT_DESKTOP" = x"GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"
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

export PATH=$HOME/.local/bin:$HOME/bin:$PATH:$GOPATH/bin:$HOME/node_modules/.bin

export XKB_DEFAULT_MODEL=pc104

export XKB_DEFAULT_LAYOUT=us

export XKB_DEFAULT_VARIANT=altgr-intl

export XKB_DEFAULT_OPTIONS="lv3:ralt_alt,caps:super,lv3:lwin_switch"

export _JAVA_AWT_WM_NONREPARENTING=1

export PYTHONSTARTUP=$HOME/.pystartup

export ANDROID_HOME=/opt/android-sdk

export NODE_REPL_HISTORY_FILE=~/.node_history

export WLC_REPEAT_DELAY=250

export WLC_REPEAT_RATE=30

export WINEDEBUG=-all

export IMDB_RENAME_DATA_DIR=~/.cache/imdb-rename

# [ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

pgrep -u $(id -u) ssh-agent > /dev/null || (eval $(ssh-agent) && ssh-add)

export PATH="$PATH:$HOME/.elan/bin"

export GUIX_PROFILE="$HOME/.config/guix/current"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/pnrao/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/pnrao/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<


export PATH="$PATH:~/opt/ghidra/"
