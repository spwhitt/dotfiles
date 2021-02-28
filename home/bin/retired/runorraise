#!/usr/bin/env bash

class="$1"
command="$2"

# Raise or start appropriate window
~/.scripts/raiserecent.sh $class || $command

# Warp mouse pointer to window
xdotool getactivewindow mousemove -w '%1' 0 0
