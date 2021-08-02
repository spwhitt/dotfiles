{ config, pkgs, ... }:

{

  # hardware.nvidia.package = pkgs.linuxPackages.nvidia_x11_legacy390;

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

  # Theme qt to match gtk
  qt5.enable = true;
  qt5.platformTheme = "gnome"; # gtk2 or gnome
  qt5.style = "adwaita";

  # services.gnome.gnome-online-accounts.enable = true;

  environment.systemPackages = with pkgs; [

    # Wayland now...
    # xorg.xkill
    # xbindkeys
    # xdotool
    # wmctrl
    # jumpapp

    gnome.gnome-tweaks
    gnomeExtensions.material-shell
    gnome-magic-window
  ];
}
