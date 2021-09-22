export PATH=$HOME/.local/bin:$PATH
export PATH=/opt/riscv/bin:$PATH

export LD_LIBRARY_PATH=/opt/systemc/lib-linux64
export LD_LIBRARY_PATH=/opt/uvm-systemc/lib-linux64:$LD_LIBRARY_PATH

# Editor settings
export VISUAL=vim
export EDITOR="$VISUAL"

# Prompt theme
PS1="$ "

# Aliases
alias c="clear"
alias ll="ls -l"
alias la="ls -la"

alias ec="vim $HOME/.bashrc"
alias rc="source $HOME/.bashrc"
alias ev="vim $HOME/.vimrc"
alias et="vim $HOME/.tmux.conf"

alias ta="tmux attach"

export DISPLAY=localhost:0.0

# Fix env. var. autocomplete broken on Bash 4.2
# http://lists.gnu.org/archive/html/bug-bash/2011-02/msg00274.html 
shopt -s direxpand

# History
shopt -s histappend
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

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
