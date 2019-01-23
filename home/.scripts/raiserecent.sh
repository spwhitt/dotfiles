#!/usr/bin/env bash

# Desired window class
app=$1

# Get current workspace
workspace=$(wmctrl -d | grep '\*' | cut -d ' ' -f1)

# List windows matching desired class on current workspace
win_list=$(wmctrl -lx | grep $app | grep " $workspace " | awk '{print $1}')

# Get window stacking order
IDs=$(xprop -root|grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
IDs=(${IDs##*#})

# Iterate through window IDs in stacking order, top to bottom
for (( idx=${#IDs[@]}-1 ; idx>=0 ; idx-- )) ; do

    # If the window matches our class, raise it and exit
    for i in $win_list; do
        if [ $((i)) = $((IDs[idx])) ]; then
            wmctrl -ia $i
            exit 0
        fi
    done
done

exit 1
