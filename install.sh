#!/usr/bin/env bash

stow config
stow osx

# if [ ! -e $HOME/.vim/autoload/plug.vim ]; then
#     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# fi

if [ ! -e $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Directory for Vim's persistent undo feature
# mkdir -p ~/.vim/undo

if [ ! -e $HOME/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

nvim +PlugClean! +PlugInstall +qall

