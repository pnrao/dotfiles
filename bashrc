# If not running interactively, don't do anything
[[ $- != *i* ]] && return

bgcolor

HISTFILE=~/.sh_history
HISTSIZE=100000
SAVEHIST=100000

# Alias definitions.
if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

export PS1="[\[\033[1;32m\]\$? \[\033[1;34m\]\u@\h\[\033[1;31m\] \w\[\033[0m\]]
\\$ "

if [[ $TERM="xterm-kitty" ]] ; then
	source <(kitty + complete setup bash)
fi

fortune
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

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

eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"
true
