{ config, pkgs, ... }:

# Release 20.09 pulseSupport defaults false for some reason
# Unstable already has it default true. TODO: remove on upgrade
let mywaybar = pkgs.waybar.override{ pulseSupport = true; };
in
{
  # Trying wayland
  programs.sway = {
    enable = true;

    # Not sure what this does
    # wrapperFeatures.gtk = true;

    # These simply get added to systemPackages
    # I'm managing it myself in systemPackages
    extraPackages = [];

    # I'm doing this in .zprofile at the moment instead
    # extraSessionCommands = ''
      # export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      # export QT_QPA_PLATFORM=wayland
      # export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      # export _JAVA_AWT_WM_NONREPARENTING=1
    # '';
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard # Clipboard for wayland
    # mywaybar # disabled because not needed in terminal

    sway-contrib.grimshot # More convenient CLI for grim/slurp
    slurp # Wayland region selection - compatible with grim, wf-recorder...
    grim # Wayland screenshots
    wf-recorder # Wayland screencasts

    # obs-studio # Livestreaming, recording...
    # obs-wlrobs # Plugin for obs studio supporting Sway

    # Sway utilities
    swaylock
    swayidle
    xwayland

    dmenu # dmenu_path seems to be the best way to get a list of executables
    rofi # dmenu-like fuzzy finder
    wofi # rofi like tool for wayland
    bemenu # dmenu alternative

    networkmanager_dmenu

    xorg.xeyes # Use to determine if a window is running in xorg or wayland

    playerctl # Control music
    yad # Yet another dialog
  ];

  # Waybar icons
  fonts.fonts = [ pkgs.font-awesome ];

  # Writing my own in an attempt to implement reload
  # programs.waybar.enable = true;
  systemd.user.services.waybar = {
    description = "Waybar as systemd service";
    wantedBy = [ "sway-session.target" ];
    partOf = [ "graphical-session.target" ];

    # Scripts run from waybar require executables on PATH
    # TODO: Make these scripts independent of PATh
    path = [ "/run/current-system/sw/bin" ];

    serviceConfig = {
      ExecStart = "${mywaybar}/bin/waybar";

      # The docs claim this should work, but actually it kills waybar
      # Issue: https://github.com/Alexays/Waybar/issues/1017
      ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
    };
  };

  # Target triggered in sway config file after sway starts
  systemd.user.targets.sway-session = {
    description = "Sway session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  # Screen off + suspend on idle
  systemd.user.services.swayidle = {
    description = "Idle Manager for Wayland";
    documentation = [ "man:swayidle(1)" ];
    wantedBy = [ "sway-session.target" ];
    partOf = [ "graphical-session.target" ];
    path = [ pkgs.bash ]; # swayidle expects to find sh on path
    serviceConfig = {
      ExecStart = '' ${pkgs.swayidle}/bin/swayidle -w -d \
        timeout 300 '${pkgs.sway}/bin/swaymsg "output * dpms off"' \
        resume '${pkgs.sway}/bin/swaymsg "output * dpms on"' \
        timeout 600 '${pkgs.systemd}/bin/systemctl suspend' \
        after-resume '${pkgs.sway}/bin/swaymsg "output * dpms on"'
      '';
    };
  };

  # Option to run sway as a user service. Not sure this is necessary
  # systemd.user.services.sway = {
  #   description = "Sway - Wayland window manager";
  #   documentation = [ "man:sway(5)" ];
  #   bindsTo = [ "graphical-session.target" ];
  #   wants = [ "graphical-session-pre.target" ];
  #   after = [ "graphical-session-pre.target" ];
  #   # We explicitly unset PATH here, as we want it to be set by
  #   # systemctl --user import-environment in startsway
  #   environment.PATH = lib.mkForce null;
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = ''
  #       ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
  #     '';
  #     Restart = "on-failure";
  #     RestartSec = 1;
  #     TimeoutStopSec = 10;
  #   };
  # };

  # WOB - Progress bar popup
  # Socket activates it and passes data to it
  # systemd.user.sockets.wob = {
  #   wantedBy=["sockets.target"];
  #   requiredBy=["wob.service"];
  #   socketConfig = {
  #     SocketMode = "0600";
  #     ListenFIFO = "%t/wob.fifo";
  #   };
  # };

  # TODO: keeps crashing and not recovering
  # Disabled for now, waybar does enough
  # systemd.user.services.wob = {
  #   description = "A lightweight overlay progress bar for Wayland";
  #   documentation = [ "man:wob(1)" ];
  #   partOf = [ "graphical-session.target" ];
  #   wantedBy = [ "sway-session.target" ];
  #   serviceConfig = {
  #     StandardInput = "socket";
  #     ExecStart = "${pkgs.wob}/bin/wob";
  #     Restart="always";
  #     RestartSec="3";
  #   };
  # };

}
