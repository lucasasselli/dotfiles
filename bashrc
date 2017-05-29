# Add Linuxbrew to path
if [ -d $HOME/.optional/Linuxbrew ]; then
    PATH="$HOME/dotfiles/.install/Linuxbrew/bin:$PATH"
fi

# Sets default shell to zsh even if there's not root access
export SHELL=$(which zsh)
exec /bin/zsh -l
