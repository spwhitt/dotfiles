Dotfiles
=========

These files are managed with stow

Add -n to any stow command to perform a dry run


## Install Dotfiles

```sh
stow -v -t $HOME home
```

## Install OSX Specific Dotfiles

```sh
stow -v -t $HOME osx
```

## Install NixOS Configuration

```sh
stow -v 0-t /etc/nixos nixos-clippy
```
