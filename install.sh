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
install "zshrc" "${HOME}/.zshrc"

#install "awesome" "${HOME}/.config"
#install "awesome.session" "/usr/share/gnome-session/sessions/awesome.session"
#install "gnome-awesome.desktop" "/usr/share/xsessions/gnome-awesome.desktop"

#install "i3/config" "${HOME}/.i3/config"
#install "i3/i3status.conf" "${HOME}/.i3status.conf"
if [ ! -L ~/.i3 ]
then
    echo "Placing symbolic link for ~/.i3"
    mv ~/.i3 ~/.i3-orig
    install "i3" "${HOME}/.i3"
fi

sudo install "i3/i3.session" "/usr/share/gnome-session/sessions/"
sudo install "i3/i3-gnome.desktop" "/usr/share/xsessions/"
sudo install "i3/i3.desktop" "/usr/share/applications/"

# Disable gnome desktop
gsettings set org.gnome.desktop.background show-desktop-icons false

# Gnome terminal settings
install "gnome-terminal.xml" "${HOME}/.gconf/apps/gnome-terminal/profiles/Default/%gconf.xml"

# Install vundle if necessary
if [ ! -e ${HOME}/.vim/bundle/vundle ]
then
    echo "Installing vundle"
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

    # Install the vim packages managed by vundle
    vim +BundleInstall +qall
fi

# Install oh-my-zsh if necessary
if [ ! -e ${HOME}/.oh-my-zsh ]
then
    echo "Installing oh-my-zsh"
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

# A patched and pretty dmenu
if [ ! -e ./dmenu2 ]
then
    echo "Installing dmenu2"
    hg clone https://bitbucket.org/melek/dmenu2
    cd dmenu2
    make
    sudo make install
    cd ..
fi

