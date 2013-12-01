# The following lines were added by compinstall

zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _approximate _prefix
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=0
zstyle ':completion:*' prompt '%e errors>'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true

zstyle :compinstall filename '/home/prash/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt appendhistory autocd extendedglob nomatch notify histexpiredupsfirst histignorealldups histreduceblanks prompt_subst

unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -Uz vcs_info
zstyle ':vcs_info:*'   actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*'   formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f'
zstyle ':vcs_info:(svn|git|hg):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git svn hg

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

# key[Home]=${terminfo[khome]}
# key[End]=${terminfo[kend]}
# key[Insert]=${terminfo[kich1]}
# key[Delete]=${terminfo[kdch1]}
# key[Up]=${terminfo[kcuu1]}
# key[Down]=${terminfo[kcud1]}
# key[Left]=${terminfo[kcub1]}
# key[Right]=${terminfo[kcuf1]}
# key[PageUp]=${terminfo[kpp]}
# key[PageDown]=${terminfo[knp]}

# setup key accordingly
# [[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
# [[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
# [[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
# [[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
# [[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
# [[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
# [[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
# [[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# # Finally, make sure the terminal is in application mode, when zle is
# # active. Only then are the values from $terminfo valid.
# if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
# 	function zle-line-init () {
# 		printf '%s' "${terminfo[smkx]}"
# 	}
# 	function zle-line-finish () {
# 		printf '%s' "${terminfo[rmkx]}"
# 	}
# 	zle -N zle-line-init
# 	zle -N zle-line-finish
# fi
# 
# [[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
# [[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

autoload -U colors && colors

# Alias definitions.
if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

precmd () { vcs_info }
prompt=$'\[%{\e[1;32m%}%? %{\e[1;34m%}%n %{\e[1;31m%}%~ %{\e[0m%}%{\e[1;35m%}${vcs_info_msg_0_}%{\e[0m%}\]
%# '
#prompt=$'\[%{\e[1;32m%}%? %{\e[1;34m%}%n %{\e[1;31m%}%~%{\e[0m%}%{\e[0m%}\]
#%# '

TIMEFMT="%J
%U user, %S system, %P cpu, %*E total
%XKB avg. code, %DKB avg. data, %KKB avg. both, %MKB peak, %F disk swaps"


#. ~/src/theli/theli-1.6.1/pipesetup/pipe_env.bash.Linux_64

stty -ixon
