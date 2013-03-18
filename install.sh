#!/bin/bash

function install {
    # TODO: Offer to replace symbolic link
    if [ -h $2 ]
    then
        echo "Symbolic link $2 already exists"
        return
    fi

    #TODO: Ask before backing up
    if [ -f $2 ]
    then
        echo "$2 already exists, moving to $2-orig"
        mv $2 $2-orig
    fi

    ln -s $PWD/$1 $2
}

install "ssh_config" "${HOME}/.ssh/config"
install "bash_config" "${HOME}/.bash_config"
install "vimrc" "${HOME}/.vimrc"
install "gitconfig" "${HOME}/.gitconfig"
install "pentadactylrc" "${HOME}/.pentadactylrc"
install "awesome" "${HOME}/.config"
install "zshrc" "${HOME}/.zshrc"

install "awesome.session" "/usr/share/gnome-session/sessions/awesome.session"
install "gnome-awesome.desktop" "/usr/share/xsessions/gnome-awesome.desktop"

# Install vundle if necessary
if [ ! -e ${HOME}/.vim/bundle/vundle ]
then
    echo "Installing vundle"
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

# Install oh-my-zsh if necessary
if [ ! -e ${HOME}/.oh-my-zsh ]
then
    echo "Installing oh-my-zsh"
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

echo
echo "To complete the install, run the following command, if necessary:"
echo "echo \". ~/.bash_config\" >> ~/.bashrc"
