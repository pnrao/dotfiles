# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions (starship, zoxide, fzf, mise, ...)
source "$OMARCHY_PATH/default/bash/rc"

if [[ "$COLORTERM" == "kmscon" ]]; then
    export COLORTERM=truecolor
fi
bgcolor

HISTFILE=~/.sh_history
HISTSIZE=100000
HISTFILESIZE=100000

# Alias definitions.
if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

if [ -f ~/private-exports ]; then
	. ~/private-exports
fi

# Prompt: starship (set up by Omarchy's rc) where available, else my own
if ! declare -F starship_precmd >/dev/null; then
	export PS1="[\[\033[1;32m\]\$? \[\033[1;34m\]\u@\h\[\033[1;31m\] \w\[\033[0m\]]
\\$ "
fi

if [[ $TERM == "xterm-kitty" ]] && command -v kitty >/dev/null; then
	source <(kitty + complete setup bash)
fi

command -v fortune >/dev/null && fortune
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"
eval "$(typst completions bash)"
# eval "$(asdf completion bash)"

# Emit OSC 7 to notify foot of current directory (enables Ctrl+Shift+N to open in same dir)
function osc7_pwd() {
    printf "\e]7;file://%s%s\e\\" "${HOSTNAME}" "${PWD}"
}
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_pwd"
osc7_pwd

true
