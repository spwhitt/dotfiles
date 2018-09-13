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
  boot.kernelParams = [ "acpi_backlight=vendor" ];

  networking.hostName = "clippy";
  networking.networkmanager.enable = true;
  # networking.firewall.allowedTCPPorts = [ 6680 ];
  
  fonts.fonts = [
    pkgs.source-code-pro
  ];

  nixpkgs.config = {
    allowUnfree = true;
    # chromium.enablePepperFlash = true;

    # Doesn't appear to work yet, but enabling in case it's fixed
    # chromium.enableWideVine = true;
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;

  # services.mopidy.enable = true;
  # services.mopidy.extensionPackages = with pkgs; [
  #   # Backends
  #   mopidy-spotify
  #   # mopidy-spotify-tunigo
  #   mopidy-soundcloud
  #   mopidy-youtube

  #   # Web interfaces
  #   mopidy-moped
  #   mopidy-mopify
  #   mopidy-musicbox-webclient
  # ];

  # services.mopidy.configuration = ''
  #   [mpd]
  #   hostname = ::

  #   [audio]
  #   mixer_volume = 20

  #   [spotify]
  #   enabled = true
  #   username = ehloha
  #   password = 5lAp30biGvnd

  #   [http]
  #   enabled = true
  #   hostname = 0.0.0.0
  #   port = 6680
  #   static_dir =
  #   zeroconf = Mopidy HTTP server on $hostname

  #   [mopify]
  #   enabled = true
  #   debug = false

  #   [soundcloud]
  #   auth_token = 1-35204-191607214-3015b57cccfa20
  # '';

  environment.systemPackages = with pkgs; [
    # Applications
    # firefox
    chromium

    # Terminal utils
    ack
    fasd
    wget
    htop
    tmux
    mosh
    git
    git-lfs
    vim
    rcm
    tree
    psmisc # killall, etc

    # Filesystem support
    # fuse_exfat
    # exfat-utils
    dropbox

    # Dev
    nodejs-8_x
    libpng12

    xfce.xfce4-power-manager
    # xfce.xfce4-display-settings

    # Modify backlight
    light
    # Network manager applet
    networkmanagerapplet
    # Pulse audio applet
    pa_applet
  ];

  virtualisation.docker.enable = true;

  programs.zsh.enable = true;
  programs.xonsh.enable = true;
  programs.fish.enable = true;

  # programs.zsh.enableCompletion = true;
  programs.bash.enableCompletion = true;
  # programs.way-cooler.enable = true;

  # services.thinkfan.enable = true;

  # Power management
  services.tlp.enable = true;

  programs.plotinus.enable = true;

  hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;

  services.printing.enable = true;

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
    # Make the Caps Lock key an additional escape
    xkbOptions = "caps:escape";
    videoDrivers = [
      # "nouveau"
      "nvidia"
    ];

    # deviceSection = ''
    #   Identifier "NVIDIA"
    #   Driver "nvidia"
    #   Option  "NoLogo" "True"
    #   Option "RegistryDwords" "EnableBrightnessControl=1"
    # '';

    # Touch pad settings
    libinput = {
      enable = true;
      naturalScrolling = true;

    };

    # synaptics = {
    #   enable = true;

    #   # Two finger gesture to scroll
    #   twoFingerScroll = true;
    #   vertEdgeScroll = false;

    #   # Natural scrolling (inverted)
    #   additionalOptions = ''
    #     Option "VertScrollDelta" "-101"
    #     Option "HorizScrollDelta" "-101"
    #   '';
    # };

    # Enable the KDE Desktop Environment.
    displayManager.slim = {
      enable = true;
      defaultUser = "swhitt";
      autoLogin = true;
    };

    # displayManager.sddm.enable = true;
    # displayManager.lightdm.enable = true;
    # desktopManager.kde4.enable = true;
    # desktopManager.gnome3.enable = true;
    # desktopManager.xfce.enable = true;
    windowManager.default = "i3";
    windowManager.awesome = {
      enable = true;
    };
    windowManager.i3 = {
      enable = true;
    };
  };

  # services.gnome3.gnome-online-accounts.enable = true;
  # services.gnome3.sushi.enable = true;
  # services.gnome3.gvfs.enable = true;

  services.emacs.enable = true;

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
}
