{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";

    xkbOptions = "caps:super";

    # Touch pad settings
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    desktopManager.gnome.enable = true;
    displayManager.sddm.enable = true;

  };

  # services.gnome.gnome-online-accounts.enable = true;

  environment.systemPackages = with pkgs; [
    xorg.xkill
    xbindkeys
    xdotool
    wmctrl

    gnome.gnome-tweaks
    gnomeExtensions.paperwm
  ];

}
