# # Autoload tmux if not in it
# if [ ! -z $(which tmux) ]; then
#     if [ "$TMUX" = "" ]; then tmux; fi
# else
#     echo "zsh not intalled!"
# fi

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
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# }}}

setopt appendhistory
setopt autocd
setopt extendedglob
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space
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
alias lll="ll | less"
alias la="ls -l -a"
alias lal="la | less"

alias mkdir="mkdir -pv" # mkdir and parents


alias ez="vim $HOME/.zshrc"
alias ev="vim $HOME/.vimrc"
alias rz="source $HOME/.zshrc"

# }}}

# {{{ FUNCTIONS

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ./$1    ;;
          *.tar.gz)    tar xvzf ./$1    ;;
          *.tar.xz)    tar xvJf ./$1    ;;
          *.lzma)      unlzma ./$1      ;;
          *.bz2)       bunzip2 ./$1     ;;
          *.rar)       unrar x -ad ./$1 ;;
          *.gz)        gunzip ./$1      ;;
          *.tar)       tar xvf ./$1     ;;
          *.tbz2)      tar xvjf ./$1    ;;
          *.tgz)       tar xvzf ./$1    ;;
          *.zip)       unzip ./$1       ;;
          *.Z)         uncompress ./$1  ;;
          *.7z)        7z x ./$1        ;;
          *.xz)        unxz ./$1        ;;
          *.exe)       cabextract ./$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

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
