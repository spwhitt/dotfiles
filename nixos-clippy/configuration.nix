{ config, pkgs, ... }:
let
  # runorraise = pkgs.haskellPackages.callPackage
  #   /home/swhitt/Data/Projects/runorraise/runorraise.nix { };
  handlr = pkgs.callPackage ./handlr.nix { };
  gnome-magic-window = pkgs.callPackage ./gnome-magic-window.nix { };
in {
  imports = [
    ./hardware-configuration.nix
    ./modules/vpn.nix
    ./modules/audio.nix
    # ./modules/sway.nix
    # ./modules/kde.nix
    ./modules/gnome.nix
    ./modules/backlight.nix
    ./modules/dropbox.nix
    ./modules/googledrive.nix
    ./modules/printscan.nix
    ./modules/backup/default.nix
    ./modules/user.nix
    ./modules/nix-index.nix
  ];

  # Fix external monitor resolution
  boot.kernelParams = [ "video=VGA-1:1920x1080@60" ];

  # Fix conflicting definition
  programs.ssh.askPassword =
    pkgs.lib.mkForce "${pkgs.plasma5Packages.ksshaskpass.out}/bin/ksshaskpass";

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
    pkgs.iosevka
    # pkgs.powerline-fonts
  ];

  security.sudo.wheelNeedsPassword = false;

  # Include ~/bin in the path
  environment.homeBinInPath = true;

  environment.systemPackages = with pkgs; [
    gnome-magic-window

    jq # Manipulate JSON in CLI
    jc # Parse command output to produce JSON

    tmux

    # Hardware info
    lshw
    hwinfo

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
    thunderbird
    aerc
    w3m # for visualizing html in aerc
    # anki
    okular
    # Very fast keybaord driven pdf, djvu, etc. reader
    zathura
    foliate # Finally a decent epub reader!
    feh
    mpv

    gnupg

    xdg_utils # For managing desktop standards

    # Linters, Formatters, and Language Servers
    nixfmt # Format nix code
    rnix-lsp # Language Server for Nix
    shellcheck # Shell script linting
    vim-vint # Linter for viml

    # For ANKI
    # pdf2svg
    # imagemagick

    # Terminal utils
    fasd
    fd # Faster find
    ripgrep # Faster grep

    fzf

    wget
    htop
    #mosh
    git
    neovim
    neovim-qt
    emacs
    tree
    psmisc # killall, etc
    dtrx
    ispell
    direnv

    # ncurses disk usage
    ncdu

    # Terminal Emulators
    alacritty
    kitty

    # Basic linux utils
    usbutils
    file
    unrar
    binutils

    # Library management
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

  # Nix Related Config
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.nat.externalInterface = "wlp3s0";
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];

  containers.secure = {
    config = { config, pkgs, ... }: {
      users.extraUsers.secure = {
        name = "secure";
        uid = 1000;
        isNormalUser = true;
      };
      environment.systemPackages = with pkgs; [ firefox zathura ];
    };
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
