#!/usr/bin/env bash

# Use saltstack to install dotfiles

sudo salt-call --local --file-root=. state.sls base
