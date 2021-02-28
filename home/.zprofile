# Automatically start sway after logging into tty 1
if [ "$(tty)" = "/dev/tty1" ]; then
  export XDG_SESSION_TYPE="wayland"
  export XDG_CURRENT_DESKTOP="sway"

  export SDL_VIDEODRIVER="wayland"

  export MOZ_ENABLE_WAYLAND=1
  export MOZ_DBUS_REMOTE=1

  export _JAVA_AWT_WM_NONREPARENTING=1

  # Run sway logging to systemd
  exec systemd-cat --identifier=sway sway
fi
