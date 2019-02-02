{ config, pkgs, ... }:

let
# mypkgs = import /home/swhitt/nixpkgs {};

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
  networking.firewall.allowedTCPPorts = [ 3000 8080 ];

  # services.openvpn.servers = {
  #   nordvpn = {
  #     config = builtins.readFile "/etc/nixos/ovpn/ovpn_udp/us1167.nordvpn.com.udp.ovpn";
  #   };
  # };

  fonts.fonts = [
    pkgs.source-code-pro
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    # Applications
    firefox
    chromium
    slack
    anki
    xpdf
    evince
    calibre
    fbreader
    feh
    inkscape
    vlc
    zotero

    # Terminal
    rxvt_unicode

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
    rcm
    tree
    psmisc # killall, etc
    dtrx
    imagemagick
    ispell

    # Filesystem support
    # fuse_exfat
    # exfat-utils
    dropbox

    # Dev
    ghc
    haskellPackages.Agda
    coq
    nodejs-8_x
    python3
    stack

    # Network manager applet
    networkmanagerapplet

    # Pulse audio controllers
    pamixer
    pa_applet
    pavucontrol

    # ncurses disk usage
    ncdu

    # dmenu like fuzzy finder utility
    rofi
    xbindkeys
    # Switch windows
    xdotool
    wmctrl

    # Basic linux utils
    usbutils
    file

    # Monitor control (backlight, color...)
    xorg.xbacklight
    ddcutil
    arandr # GUI for xrandr

    # Basic x utils
    xorg.xmodmap
    xorg.xev

    # Used for managing dotfiles
    stow

    # backup
    duplicity

    # (pkgs.duplicity.overrideAttrs(old: rec {
    #   patches = [ ./duplicity.patch ];
    # }))
  ];

  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  virtualisation.docker.enable = true;

  # Run emacs daemon for fast open
  services.emacs.enable = true;

  # Enable shells
  programs.zsh.enable = true;
  programs.xonsh.enable = true;
  programs.fish.enable = true;

  # programs.zsh.enableCompletion = true;
  programs.bash.enableCompletion = true;
  # programs.way-cooler.enable = true;

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

    videoDrivers = [
      # "nouveau"
      "nvidia"
    ];

    # Touch pad settings
    libinput = {
      enable = true;
      naturalScrolling = true;
    };

    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;

    # windowManager.default = "i3";
    windowManager.i3.enable = true;
    windowManager.awesome.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
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
    shell = "${pkgs.fish}/bin/fish";
  };

  time.timeZone = "America/New_York";

  nix.gc.automatic = true;
}
