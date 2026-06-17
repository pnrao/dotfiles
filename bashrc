# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ "$COLORTERM" == "kmscon" ]]; then
    export COLORTERM=truecolor
fi
bgcolor

HISTFILE=~/.sh_history
HISTSIZE=100000
SAVEHIST=100000

# Alias definitions.
if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

if [ -f ~/private-exports ]; then
	. ~/private-exports
fi

export PS1="[\[\033[1;32m\]\$? \[\033[1;34m\]\u@\h\[\033[1;31m\] \w\[\033[0m\]]
\\$ "

if [[ $TERM="xterm-kitty" ]] ; then
	source <(kitty + complete setup bash)
fi

fortune
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh



eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"

# Emit OSC 7 to notify foot of current directory (enables Ctrl+Shift+N to open in same dir)
function osc7_pwd() {
    printf "\e]7;file://%s%s\e\\" "${HOSTNAME}" "${PWD}"
}
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_pwd"
osc7_pwd

true
