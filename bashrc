# Add Linuxbrew to path
if [ -d $HOME/.optional/Linuxbrew ]; then
    PATH="$HOME/dotfiles/.install/Linuxbrew/bin:$PATH"
fi

# Sets default shell to zsh even if there's not root access
ZSH_PATH=$(which zsh)
if [ type "$ZSH_PATH" &> /dev/null ]; then
    export SHELL=$ZSH_PATH
    exec $ZSH_PATH -l
fi 
