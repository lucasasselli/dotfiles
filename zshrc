# Autoload tmux if not in it
if [ ! -z $(which tmux) ]; then
    if [ "$TMUX" = "" ]; then tmux; fi
else
    echo "zsh not intalled!"
fi

# {{{ ZSH Modules

autoload -U compinit
autoload -U promptinit
autoload -U zcalc
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
compinit
promptinit

# }}}

# {{{ HISTORY

HISTFILE=~/.histfile # History file
HISTSIZE=1000
SAVEHIST=1000
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

# }}}

setopt appendhistory autocd extendedglob
unsetopt beep

bindkey -e # Emacs mode
export KEYTIMEOUT=1 # No insert/normal delay

# Editor settings
export VISUAL=vim
export EDITOR="$VISUAL"

# Prompt theme
PROMPT="%b%n@%U%m%u>"
RPROMPT="%F{green}%~%f"

# Set dircolors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Use LS_COLORS for color completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# {{{ ALIASES 

alias c="clear"
alias ll="ls -l"
alias la="ls -l -a"
alias ez="vim $HOME/.zshrc"
alias ev="vim $HOME/.vimrc"
alias rz="source $HOME/.zshrc"

# }}}

# External files
if [ -f $HOME/.zshlocal ]; then source $HOME/.zshlocal; fi

# Path
PATH=$HOME/local/bin:$PATH

# {{{ OTHERS

# Linuxbrew
if [ -d $HOME/.linuxbrew ]; then
    PATH="$HOME/.linuxbrew/bin:$PATH"
    # export HOMEBREW_BUILD_FROM_SOURCE=1
    export MANPATH="$(brew --prefix)/share/man:$MANPATH"
    export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"
fi

# Base16 color shell
if [ -d $HOME/.base16-shell ]; then
    BASE16_SHELL=$HOME/.base16-shell/
    [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)" 
fi

# }}}

# vim:fdm=marker fdl=0
