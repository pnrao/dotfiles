#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTFILE=~/.sh_history
HISTSIZE=100000
SAVEHIST=100000

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

_JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING

export PS1="[\[\033[1;32m\]\$? \[\033[1;34m\]\u\[\033[1;31m\] \w\[\033[0m\]]
\\$ "
# . ~/src/theli/theli-1.6.1/pipesetup/pipe_env.bash.Linux_64
