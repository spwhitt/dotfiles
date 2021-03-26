#!/usr/bin/env bash

export PATH="$PATH":/run/current-system/sw/bin/

window_id=$(swaymsg -t get_tree | jq '.. | objects | select(.name? != null and .type? == "con") | [.id, .name] | join(" ")' | /home/swhitt/bin/gfzf | tr -d '"' | cut -d" " -f 1 )

if [ -z "$window_id" ]; then
  exit
fi


case "$1" in
  fetch)
    swaymsg "[con_id=\"$window_id\"]" move container to workspace current
    swaymsg "[con_id=\"$window_id\"]" focus
    ;;

  focus)
    swaymsg "[con_id=\"$window_id\"]" focus
esac
