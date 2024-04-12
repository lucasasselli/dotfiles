#    _               _              
#   | |             | |             
#   | |__   __ _ ___| |__  _ __ ___ 
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__ 
# (_)_.__/ \__,_|___/_| |_|_|  \___|
# 

# Editor settings
export VISUAL=vim
export EDITOR="$VISUAL"

export HISTCONTROL=ignoreboth:erasedups

# Prompt theme {{{
rightprompt()
{
    tput setaf 10
    printf "$C_GREEN%*s$C_RESET" $COLUMNS $(pwd)
    tput sgr0
}
PROMPT_COMMAND='PS1="\[$(tput sc; rightprompt; tput rc)\]$ "'
# }}}

# Aliases {{{
alias c="clear"
alias ll="ls -l"
alias la="ls -la"

alias ec="vim $HOME/.bashrc"
alias en="vim $HOME/.config/nvim/init.lua"
alias rc="source $HOME/.bashrc"
alias ev="vim $HOME/.vimrc"
alias et="vim $HOME/.tmux.conf"

alias t="tmux"
alias ta="tmux attach"

alias vim=nvim

# }}}

# Fix env. var. autocomplete broken on Bash 4.2
# http://lists.gnu.org/archive/html/bug-bash/2011-02/msg00274.html 
shopt -s direxpand

set bell-style none

# History
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'
set show-all-if-ambiguous on
set completion-ignore-case on

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Load local config (if any!)
if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi

# vim:fdm=marker fdl=0
