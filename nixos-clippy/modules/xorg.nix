{ config, pkgs, ... }:

{
  options = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable my xorg configuration (Broken, untested, not using it at the moment)
      '';
    };
  };

  config = mkIf cfg.enable{
    services.redshift = {
      enable = true;
      # graphical = true;
    };

  # No longer using xorg...
  systemd.user.services.xbindkeys = {
    description = "xbindkeys";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.xbindkeys}/bin/xbindkeys -n";
      Restart = "always";
      RestartSec = "3";
      PassEnvironment="DISPLAY";
    };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";

      # videoDrivers = [ "nvidia" ];

      # Make the Caps Lock key an additional super
      # (my daskeyboard has no super on the left)
      xkbOptions = "caps:super";

      # Touch pad settings
      libinput = {
        enable = true;
        naturalScrolling = true;
      };


      # displayManager.lightdm.enable = true;
      # desktopManager.xfce.enable = true;
      # displayManager.defaultSession = "xfce";
      # desktopManager.default = "xfce";

      # windowManager.default = "i3";
      # windowManager.i3.enable = true;
      # windowManager.awesome.enable = true;
      # windowManager.xmonad = {
        # enable = true;
        # enableContribAndExtras = true;
      # };
    };


    environment.systemPackages = [
      xorg.xkill
      xbindkeys
      Switch windows
      xdotool
      wmctrl
    ];

    systemd.services.ly = {
    };
  };
}
