{ config, pkgs, ... }: 
let
  # mypkgs = import /home/swhitt/nixpkgs {};
  # mypkgs = pkgs { overlays = [ (import ./nix/overlay.nix)_]; }
  # lorri = 
  # runorraise = pkgs.haskellPackages.callPackage /home/swhitt/Data/Projects/runorraise/runorraise.nix { };
  nixpkgs_manual = (import <nixpkgs/doc> { inherit pkgs; } );

  # manix = (import (fetchGit {
  #     name = "manix-unstable-master";
  #     url = "https://github.com/mlvzk/manix/";
  #     ref = "refs/tags/v0.6.2";
  #     rev = "b428f30d58e2b6955f670e21f881056ab1803541";
  #   }) { inherit pkgs; });
in
  {
    imports = [
      ./hardware-configuration.nix
      ./modules/vpn.nix
      ./modules/sway.nix
      ./modules/backlight.nix
      ./modules/dropbox.nix
      ./modules/printscan.nix
      ./modules/backup/default.nix
    ];

  # steam
  # hardware.opengl.driSupport32Bit = true;
  # hardware.pulseaudio.support32Bit = true;
  boot.loader.timeout = 5;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  # boot.loader.grub.useOSProber = true;

  networking.hostName = "clippy";
  networking.domain = "whitt.xyz";

  networking.firewall.enable = true;

  # networking.firewall.allowedTCPPorts = [ 9090 ];
  # networking.firewall.interfaces

  documentation = {
    # Generate mandb for searching with apropos
    man.generateCaches = true;

    # Generate developer focused documentation
    dev.enable = true;
  };

  fonts.fonts = [
    pkgs.source-code-pro
    # pkgs.powerline-fonts
  ];

  security.sudo.wheelNeedsPassword = false;

  # Include ~/bin in the path
  environment.homeBinInPath = true;

  environment.systemPackages = with pkgs; [
    pcmanfm # File browser

    fontconfig # Useful utilities like fc-list

    bitwarden-cli

    # Use system trash from cli
    # Alternative is small script which moves files to /tmp/.trash
    trash-cli

    # Options database in json form - for searching with fzf
    # TODO: create module for nixos options fzf search tool, or remove in favor
    # of pre-existing tool (manix)
    config.system.build.manual.optionsJSON

    # Nixpkgs manual
    # TODO: Produces tons of annoying warnings on build
    # nixpkgs_manual

    # Manix: Documentation Search for Nix
    # TODO: Package is in unstable. Remove this after upgrading to next stable release
    # manix

    # Manix wrapper script for fzf
    # Unbuffer tricks Manix into outputting color
    # (writeScriptBin "fzfnix" ''
    #     #!${pkgs.runtimeShell}
    #     manix "" | grep '^#' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview="${pkgs.expect}/bin/unbuffer manix \'{}\'" | xargs manix
    #   '')

    nix-du # Analyze nix disk usage
    nix-index # Quickly find files in nix packages

    # Packages required to get gtk themed
    gnome3.adwaita-icon-theme
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    lxappearance

    # Messaging Apps
    # signal-desktop
    tdesktop

    # virt-manager

    # runorraise
    # lorri
    xfce.xfwm4themes

    rclone

    appimage-run
    p7zip
    zip
    massren

    # noteshrink
    # paperwork
    # tabula

    xournal
    # skype
    firefox
    # chromium
    # thunderbird
    # slack
    anki
    evince
    calibre # For the epub reader only
    # fbreader
    feh
    # inkscape
    vlc
    # webtorrent_desktop

    gnupg

    xdg_utils # For managing desktop standards

    fd # Faster find
    ripgrep # Faster grep
    shellcheck # Shell script linting
    # pandoc # Markdown preview

    nixfmt # Format nix code
    rnix-lsp # Language Server for Nix

    # (texlive.combine {
    # inherit(texlive) scheme-medium collection-pictures tikz-cd;
    # })

    # For ANKI
    pdf2svg
    imagemagick

    # Terminal utils
    exa
    fasd

    fzf

    wget
    htop
    #tmux
    #mosh
    git
    # git-lfs
    neovim
    vscode
    tree
    psmisc # killall, etc
    dtrx
    ispell
    direnv

    # Filesystem support
    # fuse_exfat
    # exfat-utils
    # drive

    # Network manager applet
    # networkmanagerapplet
    pavucontrol
    pamixer # Command line pulse audio control

    # ncurses disk usage
    ncdu

    # Terminal Emulators
    alacritty

    # Basic linux utils
    usbutils
    file
    unrar
    binutils

    zotero
    # libreoffice
    unzip
    whois
    bind
    pciutils
  ];

  # RSS Feed Reader
  # services.miniflux.enable = true;

  services.neo4j = {
    enable = false;
  };

  services.postgresql = {
    enable = false;
  };

  # Network Manager
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  virtualisation = {
    # Use docker
    # docker.enable = true;

    # For virt-manager
    # libvirtd.enable = true;

    # Only host architectures are required to be virtualized - save disk space
    # libvirtd.qemuPackage = pkgs.qemu_kvm;
  };

  # Run emacs daemon for fast open
  # services.emacs.enable = true;

  # Enable shells
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.interactiveShellInit = ''
    # Completions for FZF
    source ${pkgs.fzf}/share/fzf/completion.zsh
    # Alt-C cd
    # Ctrl-T paste selected file path into command line
    # Ctrl-R command history
    source ${pkgs.fzf}/share/fzf/key-bindings.zsh
    '';
    programs.bash.interactiveShellInit = ''
    # Fasd bindings
    eval "$(${pkgs.fasd}/bin/fasd --init auto)"
    # Completions for FZF
    source ${pkgs.fzf}/share/fzf/completion.bash
    # Alt-C cd
    # Ctrl-T paste selected file path into command line
    # Ctrl-R command history
    source ${pkgs.fzf}/share/fzf/key-bindings.bash
    '';

  # Power management
  # services.thinkfan.enable = true;
  services.tlp.enable = true;

  # temporarily disabled for 19.09:
  #   - https://github.com/NixOS/nixpkgs/issues/71952
  # hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  hardware.pulseaudio.enable = true;

  # Enable bluetooth, etc.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;


  # When a job won't stop for some reason, I don't want to waste 90s
  systemd.extraConfig = ''
  DefaultTimeoutStopSec=10s
  '';

  users.extraUsers.swhitt = {
    name = "swhitt";
    uid = 1000;
    isNormalUser = true;
    extraGroups = [
      "wheel" # Allow use of sudo
      "networkmanager"
      "docker"
    ];
    shell = "${pkgs.zsh}/bin/zsh";
  };

  # Localization
  time.timeZone = "America/New_York";

  location = {
    latitude = 40.712784;
    longitude = -74.005941;
  };

  # Nix Related Config
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  nix = {
    gc.automatic = true;
    autoOptimiseStore = true;

    # Enable Flakes
    # package = pkgs.nixUnstable;
    # extraOptions = ''
    #   experimental-features = nix-command flakes
    # '';
  };
}
