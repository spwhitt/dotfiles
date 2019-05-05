{ config, pkgs, ... }:

let
  # mypkgs = import /home/swhitt/nixpkgs {};
  # mypkgs = pkgs { overlays = [ (import ./nix/overlay.nix)_]; }

in
{
  imports = [ ./hardware-configuration.nix ];

  # steam
  # hardware.opengl.driSupport32Bit = true;
  # hardware.pulseaudio.support32Bit = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # For laptop backlight
  boot.kernelParams = [ "acpi_backlight=vendor" ];

  # For ddcutil to control external monitor settings (backlight, color...)
  boot.kernelModules = [ "i2c_dev" ];

  # Needed for TLP on my thinkpad
  boot.extraModulePackages = [ pkgs.linuxPackages.acpi_call ];

  networking.hostName = "clippy";
  networking.firewall.allowedTCPPorts = [];

  # Works but something is slow.
  # I think DNS is not being routed through the VPN.
  # May be better to use networkmanager-openvpn anyway.
  services.openvpn.servers = {
    nordvpn = {
      autoStart = false;
      config = ''
        config /etc/nixos/ovpn/ovpn_udp/us3395.nordvpn.com.udp.ovpn
        auth-user-pass /etc/nixos/nordvpn_auth.txt
      '';
    };
  };

  fonts.fonts = [
    pkgs.source-code-pro
    pkgs.powerline-fonts
  ];

  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
      enableAdobeFlash = true;
    };
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    xfce.xfwm4themes

    # Applications
    firefoxWrapper
    slack
    anki
    xpdf
    evince
    calibre
    fbreader
    feh
    inkscape
    vlc

    # Terminal utils
    ack
    fasd
    wget
    htop
    tmux
    mosh
    git
    git-lfs
    neovim
    tree
    psmisc # killall, etc
    dtrx
    ispell
    direnv

    # Filesystem support
    # fuse_exfat
    # exfat-utils
    dropbox
    drive

    # Network manager applet
    networkmanagerapplet

    # ncurses disk usage
    ncdu

    # dmenu like fuzzy finder utility
    rofi
    networkmanager_dmenu
    xbindkeys
    # Switch windows
    xdotool
    wmctrl

    # Basic linux utils
    usbutils
    file

    # Monitor control (backlight, color...)
    ddcutil
    light

    # Build duplicity with support for b2
    (pkgs.duplicity.overrideAttrs(old: rec {
      propagatedBuildInputs =
        old.propagatedBuildInputs ++ [ backblaze-b2 ];
    }))

    # Modified zotero
    (callPackage (import ./zotero) {})
    libreoffice
    unzip
    whois
    bind
    pciutils
  ];

  services.duplicati = {
    enable = true;
    # The default interface "lo" causes an error. This is the correct value
    interface = "loopback";
  };

  networking.networkmanager.enable = true;
  # Start VPN automatically
  networking.networkmanager.dispatcherScripts = [ {
    source = pkgs.writeScript "03startvpn" ''
      #!${pkgs.bash}/bin/bash
      VPN_NAME="us3359.nordvpn.com.udp"
      interface=$1 status=$2
      case $status in
        up|vpn-down)
          ${pkgs.networkmanager}/bin/nmcli connection up id "$VPN_NAME"
          ;;
        down)
          if ${pkgs.networkmanager}/bin/nmcli connection show --active | grep "$VPN_NAME"; then
            ${pkgs.networkmanager}/bin/nmcli connection down id "$VPN_NAME"
          fi
          ;;
      esac
    '';
    type = "basic";
  } ];

  services.openssh.enable = true;

  virtualisation.docker.enable = true;

  # Run emacs daemon for fast open
  services.emacs.enable = true;

  # Enable shells
  programs.zsh.enable = true;

  # Power management
  # services.thinkfan.enable = true;
  services.tlp.enable = true;

  hardware.bluetooth.enable = true;

  hardware.pulseaudio.enable = true;
  # Enable bluetooth, etc.
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Allow service discovery e.g. network printers
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  # services.avahi.publish.enable = true;
  # services.avahi.publish.userServices = true;

  services.printing.enable = true;
  services.printing.browsing = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.brlaser ];

  services.redshift = {
    enable = false;
    # graphical = true;
    latitude = "40.712784";
    longitude = "-74.005941";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";

    # Make the Caps Lock key an additional super
    # (my daskeyboard has no super on the left)
    xkbOptions = "caps:super";

    # Touch pad settings
    libinput = {
      enable = true;
      naturalScrolling = true;
    };

    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
    desktopManager.default = "xfce";

    # windowManager.default = "i3";
    # windowManager.i3.enable = true;
    # windowManager.awesome.enable = true;
    # windowManager.xmonad = {
      # enable = true;
      # enableContribAndExtras = true;
    # };
  };

  # sound.mediaKeys.enable = true;

  systemd.user.services.dropbox = {
    restartIfChanged = true;
    enable = true;
    serviceConfig = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      PassEnvironment = "DISPLAY";
    };
  };

  users.extraUsers.swhitt = {
    name = "swhitt";
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = "${pkgs.zsh}/bin/zsh";
  };

  time.timeZone = "America/New_York";

  nix.gc.automatic = true;
}
