# Add Linuxbrew to path
if [ -d $HOME/.linuxbrew ]; then
    PATH="$HOME/.linuxbrew/bin:$PATH"
    export HOMEBREW_BUILD_FROM_SOURCE=1
    export MANPATH="$(brew --prefix)/share/man:$MANPATH"
    export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"
fi

# Sets default shell to zsh even if there's not root access
ZSH_PATH=$(which zsh)
if [ -x $ZSH_PATH ]; then
    export SHELL=$ZSH_PATH
    exec $ZSH_PATH -l
fi 
