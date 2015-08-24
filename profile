if [ -z $DISPLAY ]; then
	EDITOR=emacs
	BROWSER=lynx
else
	EDITOR=subl3
	BROWSER=/usr/bin/google-chrome-unstable
fi
export EDITOR
export BROWSER

LESS="-i -r"
export LESS

XDG_CONFIG_HOME=$HOME/.config
export XDG_CONFIG_HOME

OPENCCG_HOME=$HOME/src/openccg-git
export OPENCCG_HOME

GOPATH=$HOME/.local/go
export GOPATH


PATH=$HOME/bin:$PATH:$HOME/.npm-packages/bin:$HOME/.gem/ruby/2.2.0/bin:/opt/android-sdk/platform-tools/:$GOPATH/bin
export PATH

#PYTHONPATH=$PYTHONPATH:~/lib/python
#export PYTHONPATH

_JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING

PYTHONSTARTUP=$HOME/.pystartup
export PYTHONSTARTUP

PYMACS_PYTHON=python2
export PYMACS_PYTHON

# export CUPS_SERVER=print.coli.uni-saarland.de

# source /opt/context-minimals/setuptex
ANALYSIS_PATH=$HOME/src/analysis
export ANALYSIS_PATH

ANDROID_HOME=/opt/android-sdk
export ANDROID_HOME

NODE_REPL_HISTORY_FILE=~/.node_history
export NODE_REPL_HISTORY_FILE

pgrep -u $EUID ssh-agent > /dev/null || (eval $(ssh-agent) && ssh-add)
