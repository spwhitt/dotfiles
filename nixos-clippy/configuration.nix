{ config, pkgs, ... }:
let
  # runorraise = pkgs.haskellPackages.callPackage /home/swhitt/Data/Projects/runorraise/runorraise.nix { };
  handlr = pkgs.callPackage ./handlr.nix { };
in {
  imports = [
    ./hardware-configuration.nix
    ./modules/vpn.nix
    ./modules/audio.nix
    ./modules/sway.nix
    # ./modules/kde.nix
    # ./modules/gnome.nix
    ./modules/backlight.nix
    ./modules/dropbox.nix
    ./modules/googledrive.nix
    ./modules/printscan.nix
    ./modules/backup/default.nix
  ];

  # Fix external monitor resolution
  boot.kernelParams = [ "video=VGA-1:1920x1080@60" ];

  # Fix conflicting definition
  programs.ssh.askPassword =
    pkgs.lib.mkForce "${pkgs.plasma5Packages.ksshaskpass.out}/bin/ksshaskpass";

  # Gruvbox
  console.colors = [
    "#f9f5d7" # black hard
    # "#fbf1c7" # black:
    "#cc241d" # red:
    "#98971a" # green:
    "#d79921" # yellow:
    "#458588" # blue:
    "#b16286" # magenta:
    "#689d6a" # cyan:
    "#7c6f64" # white:
    "#928374" # bright black:
    "#9d0006" # bright red:
    "#79740e" # bright green:
    "#b57614" # bright yellow:
    "#076678" # bright blue:
    "#8f3f71" # bright magenta:
    "#427b58" # bright cyan:
    "#3c3836" # bright white:
  ];

  boot.loader.timeout = 5;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  # Slows down every rebuild - setup manual entries instead
  # boot.loader.grub.useOSProber = true;
  boot.loader.grub.extraEntries = ''
    menuentry "Windows 7" {
      chainloader (hd1,1)+1
    }
  '';

  networking.hostName = "clippy";
  networking.domain = "whitt.xyz";

  networking.firewall.enable = true;

  # documentation = {
  #   # Generate mandb for searching with apropos
  #   man.generateCaches = true;

  #   # Generate developer focused documentation
  #   dev.enable = true;
  # };

  fonts.fonts = [
    pkgs.source-code-pro
    # pkgs.powerline-fonts
  ];

  security.sudo.wheelNeedsPassword = false;

  # Include ~/bin in the path
  environment.homeBinInPath = true;

  environment.systemPackages = with pkgs; [
    # CLI file manager
    ranger

    # zsh-syntax-highlighting
    # zsh-autosuggestions
    # zsh-completions

    # Github cli
    gh

    # Manage xdg mime in a semi-sane way
    handlr

    taskwarrior

    jq

    fontconfig # Useful utilities like fc-list

    # bitwarden-cli

    # Use system trash from cli
    # Alternative is small script which moves files to /tmp/.trash
    trash-cli

    # Options database in json form - for searching with fzf
    # TODO: create module for nixos options fzf search tool, or remove in favor
    # of pre-existing tool (manix)
    # config.system.build.manual.optionsJSON

    # Nixpkgs manual
    # TODO: Produces tons of annoying warnings on build
    # nixpkgs_manual

    # Manix: Documentation Search for Nix
    manix

    # Manix wrapper script for fzf
    # Unbuffer tricks Manix into outputting color
    # (writeScriptBin "fzfnix" ''
    #     #!${pkgs.runtimeShell}
    #     manix "" | grep '^#' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview="${pkgs.expect}/bin/unbuffer manix \'{}\'" | xargs manix
    #   '')

    nix-du # Analyze nix disk usage
    nix-index # Quickly find files in nix packages

    # Messaging Apps
    # signal-desktop
    tdesktop

    # virt-manager

    # runorraise
    # lorri
    # xfce.xfwm4themes

    rclone

    # appimage-run
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
    thunderbird
    aerc
    w3m # for visualizing html in aerc
    # slack
    # anki
    okular
    # Very fast keybaord driven pdf, djvu, etc. reader
    zathura
    # Very fast pdf viewer
    mupdf
    # evince
    calibre # For the epub reader only
    # fbreader
    feh
    # inkscape
    # vlc
    mpv
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
    # pdf2svg
    # imagemagick

    # Terminal utils
    # exa
    fasd

    fzf

    wget
    htop
    #tmux
    #mosh
    git
    # git-lfs
    neovim
    neovim-qt
    vim-vint # Linter for viml
    emacs
    # vscode
    tree
    psmisc # killall, etc
    dtrx
    ispell
    direnv

    # Filesystem support
    # fuse_exfat
    # exfat-utils
    # drive

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

  # Network Manager
  networking.networkmanager.enable = true;
  # Hoping this fixes the connection problem
  networking.networkmanager.wifi.scanRandMacAddress = false;

  # Enable shells
  programs.zsh.enable = true;
  # programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.enableBashCompletion = true;
  # programs.zsh.autosuggestions.enable = true;
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
  programs.fish.enable = true;

  # Broadcom bluetooth
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

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
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
