$!/usr/bin/env bash

laptop_display="$1"
if grep -q open /proc/acpi/button/lid/LID/state ; then
  swaymsg output "$laptop_display" enable
else
  swaymsg output "$laptop_display" disable
fi
