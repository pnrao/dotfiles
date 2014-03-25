# Lines configured by zsh-newuser-install
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _approximate _prefix
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' prompt '%e errors>'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
HISTFILE=~/.sh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob notify histreduceblanks prompt_subst Autopushd
unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/prash/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -Uz vcs_info
zstyle ':vcs_info:*'   actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*'   formats ' %f%s%F{3}:%F{2}%b%f'
zstyle ':vcs_info:(svn|git|hg):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git svn hg

autoload -U colors && colors

# Alias definitions.
if [ -e ~/.aliases ]; then
	. ~/.aliases
fi

precmd () { vcs_info }
prompt='[%{$fg_bold[green]%}%? %{$fg_bold[blue]%}%n %{$fg_bold[red]%}%~%{$fg_no_bold[default]%}${vcs_info_msg_0_}]
%# '

TIMEFMT="%J
%U user, %S system, %P cpu, %*E total
%XKB avg. code, %DKB avg. data, %KKB avg. both, %MKB peak, %F disk swaps"

stty -ixon -ixoff
