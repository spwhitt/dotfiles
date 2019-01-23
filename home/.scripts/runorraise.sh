#!/usr/bin/env bash

class="$1"
command="$2"
# xdotool search --onlyvisible --class $class windowraise windowfocus || $command
# wmctrl -x -a $class || $command
~/.scripts/raiserecent.sh $class || $command
