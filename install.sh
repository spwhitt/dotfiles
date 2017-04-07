#!/usr/bin/env bash

stow config
stow osx

if [ ! -e $HOME/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

nvim +PlugClean! +PlugInstall +qall

