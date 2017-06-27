#!/bin/bash

# Script for installing tmux, vim and zsh on systems where you don't have root access.
# tmux will be installed in $HOME/local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

TMUX_VERSION=2.5
VIM_VERSION=8.0.0606
ZSH_VERSION=1.0

LIBEVENT_VERSION=2.0.22-stable
NCURSES_VERSION=6.0

# create our directories
rm -rf $HOME/install_temp
mkdir -p $HOME/local $HOME/install_temp
cd $HOME/install_temp

# download source files for tmux, libevent, and ncurses
wget -N https://github.com/libevent/libevent/releases/download/release-$LIBEVENT_VERSION/libevent-$LIBEVENT_VERSION.tar.gz
wget -N https://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VERSION.tar.gz
wget -N https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz
wget -N https://github.com/vim/vim/archive/v$VIM_VERSION.tar.gz -O vim-$VIM_VERSION.tar.gz

# extract files, configure, and compile

##################################################
# libevent 
##################################################
tar -xzf libevent-$LIBEVENT_VERSION.tar.gz
cd libevent-$LIBEVENT_VERSION
./configure --prefix=$HOME/local --disable-shared
make
make install
cd ..

##################################################
# ncurses  
##################################################
tar -xzf ncurses-$NCURSES_VERSION.tar.gz
cd ncurses-$NCURSES_VERSION
./configure --prefix=$HOME/local CPPFLAGS="-P"
make
make install
cd ..

##################################################
# tmux     
##################################################
tar xvzf tmux-$TMUX_VERSION.tar.gz
cd tmux-$TMUX_VERSION
./configure CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib64 -L$HOME/local/include/ncurses -L$HOME/local/include"
CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib64" make
cp tmux $HOME/local/bin
cd ..

##################################################
# vim
##################################################
tar xvzf vim-$VIM_VERSION.tar.gz
cd vim-$VIM_VERSION
./configure --enable-gui=no --without-x -with-features=huge --prefix=$HOME/local --with-tlib=ncurses LDFLAGS="-L$HOME/local/lib64 -L$HOME/local/include/ncurses -L$HOME/local/include"
make
make install

# cleanup
rm -rf $HOME/install_temp
