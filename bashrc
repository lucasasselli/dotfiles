PATH=$HOME/local/bin:$PATH

# Add Linuxbrew to path
if [ -d $HOME/.linuxbrew ]; then
    PATH="$HOME/.linuxbrew/bin:$PATH"
fi

# Sets default shell to zsh even if there's not root access
ZSH_PATH=$(which zsh)
if [ -x $ZSH_PATH ]; then
    export SHELL=$ZSH_PATH
    exec $ZSH_PATH -l
else
    echo "zsh not installed!"
fi
