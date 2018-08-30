#!/usr/bin/env bash

stow -v config

# stow osx

nvim +PlugClean! +PlugInstall +qall

