#!/usr/bin/env bash

# Script to change backlight on external monitors as well as backlight

target="$1"

# Set external monitor backlight
# Must run as root
ddcutil setvcp 10 $target &

# Set laptop backlight
xbacklight -set $target &
