#!/usr/bin/env bash

if sudo killswitch-enabled; then
  echo "<b>SAFE</b> | onclick=bash bash='sudo killswitch-down' font='Source Code Pro'" kargos.fa_icon=lock
else
  echo "<b>OPEN</b> | onclick=bash bash='sudo killswitch-up' font='Source Code Pro'" kargos.fa_icon=unlock
fi
