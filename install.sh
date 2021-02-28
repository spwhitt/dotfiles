#! /usr/bin/env nix-shell
#! nix-shell -i bash -p stow
# vim: ft=bash
# shellcheck shell=bash

case $(hostname) in
  clippy)
    stow "$@" -v -t "$HOME" home
    stow "$@" -v -t /etc/nixos nixos-clippy
  ;;
esac
