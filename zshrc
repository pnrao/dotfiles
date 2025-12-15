# If not running interactively, don't do anything
[[ $- != *i* ]] && return
zmodload zsh/datetime
start=$EPOCHREALTIME
typeset -g TIMEZSHRC=0

(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"
bgcolor
export ZSH_COMPDUMP="/tmp/${USER}.zcompdump"
# Lines configured by zsh-newuser-install
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _approximate _prefix
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' prompt '%e errors>'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
HISTFILE=~/.sh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob notify histreduceblanks prompt_subst Autopushd histignorespace histignoredups incappendhistory INTERACTIVE_COMMENTS
unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall

(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"
# initialise completions with ZSH's compinit
autoload -Uz compinit
(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"
compinit -C -d $ZSH_COMPDUMP
(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"

# End of lines added by compinstall

(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"
if [ $TERM = "xterm-kitty" ] ; then
	kitty + complete setup zsh | source /dev/stdin
fi
(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"

autoload -Uz vcs_info
zstyle ':vcs_info:*'   actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*'   formats ' %f%s%F{3}:%F{2}%b%f'
zstyle ':vcs_info:(svn|git|hg):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git svn hg

autoload -U colors && colors
autoload zmv

(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[comment]='fg=cyan'
(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"

source /etc/zsh_command_not_found
(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"

# Alias definitions.
if [ -e ~/.aliases ]; then
	. ~/.aliases
	(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"
fi

precmd () { vcs_info }
prompt='[%{$fg_bold[green]%}%? %{$fg_bold[blue]%}%n@%m %{$fg_bold[red]%}%~%{$fg_no_bold[default]%}${vcs_info_msg_0_}]
%# '

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" history-beginning-search-forward
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init () {
		printf '%s' "${terminfo[smkx]}"
	}
	function zle-line-finish () {
		printf '%s' "${terminfo[rmkx]}"
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi
(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"

TIMEFMT="%J
%U user, %S system, %P cpu, %*E total
%XKB avg. code, %DKB avg. data, %KKB avg. both, %MKB peak, %F disk swaps"

stty -ixon -ixoff
(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"
fortune
(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"


(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"


# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Line $LINENO"

# { # Load additional completions in the background after startup
  eval "$(uv generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
# } &!

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

(( TIMEZSHRC )) && echo "[$(( (EPOCHREALTIME - start) * 1000 ))ms] Total load time"
true # start with a clean exit status
