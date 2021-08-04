{ config, pkgs, ... }: {
  users.users.swhitt = {
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

  # Applications
  environment.systemPackages = with pkgs; [
    ##
    # Applications

    # Messaging
    # skype
    # signal-desktop
    tdesktop

    # Web
    firefox
    w3m # for visualizing html in aerc

    # Email
    thunderbird
    aerc

    # Viewers
    okular
    zathura
    foliate # Finally a decent epub reader!
    feh
    (mpv.override { scripts = [ mpvScripts.mpris ]; })

    # Editors
    neovim
    emacs
    xournal
    # libreoffice

    # Library management
    zotero

    # noteshrink
    # paperwork
    # tabula

    # anki

    # Terminal Emulators
    alacritty
    kitty

    # Weather
    wego

    # File manager
    ranger

    simple-scan

    arandr

    jq # Manipulate JSON in CLI
    jc # Parse command output to produce JSON

    # tmux

    # zsh-syntax-highlighting
    # zsh-autosuggestions
    # zsh-completions

    taskwarrior

    # Passwords
    bitwarden
    bitwarden-cli

    # Use system trash from cli
    # Alternative is small script which moves files to /tmp/.trash
    trash-cli

    ##
    # Nix Utilities
    manix
    nix-du
    nix-index
    # lorri
    # appimage-run

    # Options database in json form - for searching with fzf
    # TODO: create module for nixos options fzf search tool, or remove in favor
    # of pre-existing tool (manix)
    # config.system.build.manual.optionsJSON

    # Nixpkgs manual
    # TODO: Produces tons of annoying warnings on build
    # nixpkgs_manual

    # Manix wrapper script for fzf
    # Unbuffer tricks Manix into outputting color
    # (writeScriptBin "fzfnix" ''
    #     #!${pkgs.runtimeShell}
    #     manix "" | grep '^#' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview="${pkgs.expect}/bin/unbuffer manix \'{}\'" | xargs manix
    #   '')

    direnv

    rclone

    # Compression
    dtrx
    p7zip
    zip
    unzip
    unrar

    # Encryption
    gnupg

    # xdg-open, xdg-mime, xdg-settings...
    xdg_utils

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
    fd # Better find
    ripgrep # Better grep
    fzf

    # Hardware info
    lshw
    hwinfo

    # System Monitors
    # htop
    bottom

    psmisc # killall, etc

    wget
    #mosh
    # Github cli
    gh
    git

    ispell

    # ncurses disk usage
    ncdu

    # Manage xdg mime in a semi-sane way
    handlr

    # fontconfig # Useful utilities like fc-list

    # Basic linux utils
    usbutils # lsusb
    file
    # binutils # ld, ar, nm, objdump, strip, etc..
    tree
    massren

    whois
    # bind
    pciutils
  ];

}
