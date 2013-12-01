if [ -z $DISPLAY ]; then
	EDITOR=emacs
	BROWSER=lynx
else
	EDITOR=kwrite
	BROWSER=~/bin/some-browser.sh
fi
export EDITOR
export BROWSER

LESS="-i -r"
export LESS
#LESSCOLORIZER=pygmentize
#export LESSCOLORIZER

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

# export CUPS_SERVER=print.coli.uni-saarland.de

# source /opt/context-minimals/setuptex
ANALYSIS_PATH=/home/prash/src/prash/analysis
export ANALYSIS_PATH

export ANDROID_HOME=/opt/android-sdk

fortune
echo ________________________________________________________________________________
