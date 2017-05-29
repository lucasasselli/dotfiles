# Sets default shell to zsh even if there's not root access
export SHELL='which zsh'
[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l
