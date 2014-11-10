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

OPENCCG_HOME=/home/prash/src/openccg-git
export OPENCCG_HOME

#GOROOT=/home/prash/src/go
#export GOROOT

GOPATH=/home/prash/src/golib:$GOPATH
export GOPATH

PATH=.:$HOME/bin:$PATH
export PATH

#PYTHONPATH=$PYTHONPATH:~/lib/python
#export PYTHONPATH

_JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING

PYTHONSTARTUP=/home/prash/.pystartup
export PYTHONSTARTUP

PYMACS_PYTHON=python2
export PYMACS_PYTHON

# export CUPS_SERVER=print.coli.uni-saarland.de

# source /opt/context-minimals/setuptex
ANALYSIS_PATH=/home/prash/src/analysis
export ANALYSIS_PATH

ANDROID_HOME=/opt/android-sdk
export ANDROID_HOME

pgrep -u $EUID ssh-agent || (eval $(ssh-agent) && ssh-add)
