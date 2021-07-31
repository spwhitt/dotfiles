{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";

    xkbOptions = "caps:super";

    # Nouveau working for now!
    # videoDrivers = [ "nvidia" ];

    # Touch pad settings
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

  };

  # services.gnome.gnome-online-accounts.enable = true;

  environment.systemPackages = with pkgs;
    [

      # Wayland now...
      # xorg.xkill
      # xbindkeys
      # xdotool
      # wmctrl
      # jumpapp

      gnome.gnome-tweaks
    ];
}
