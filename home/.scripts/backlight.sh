#!/usr/bin/env bash

# Script to change backlight on any monitor as well as backlight
# Must run as root

target="$1"

# Set external monitor backlight
ddcutil setvcp 10 $target &

# Set laptop backlight
xbacklight -set $target &

# New graphics driver doesn't support xbacklight for laptop screen
# Another option would be brightnessctl
light -S $target &
