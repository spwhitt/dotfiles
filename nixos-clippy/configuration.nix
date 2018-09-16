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

  # Needed for TLP on my thinkpad
  boot.extraModulePackages = [ pkgs.linuxPackages.acpi_call ];

  networking.hostName = "clippy";
  # networking.firewall.allowedTCPPorts = [ 6680 ];
  
  fonts.fonts = [
    pkgs.source-code-pro
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  security.sudo.wheelNeedsPassword = false;

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

    # Network manager applet
    networkmanagerapplet

    # Pulse audio applet
    pa_applet
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

    windowManager.default = "i3";
    windowManager.i3.enable = true;
    windowManager.awesome.enable = true;
    windowManager.xmonad.enable = true;
  };

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
