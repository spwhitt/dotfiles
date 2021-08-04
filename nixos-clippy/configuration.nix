{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules/vpn.nix
    ./modules/audio.nix
    # ./modules/sway.nix
    ./modules/kde.nix
    # ./modules/gnome.nix
    ./modules/backlight.nix
    ./modules/dropbox.nix
    ./modules/googledrive.nix
    ./modules/printscan.nix
    ./modules/backup/default.nix
    ./modules/user.nix
    ./modules/nix-index.nix
  ];

  # Package overlays
  nixpkgs.overlays = [
    (self: super: {
      # My run-or-raise based on xdotool - so obsolete now with move to wayland
      runorraise = super.pkgs.haskellPackages.callPackage
        /home/swhitt/Data/Projects/runorraise/runorraise.nix { };

      # run-or-raise for kde
      ww-run-raise = super.pkgs.callPackage ./pkgs/ww.nix { };

      # run-or-raise for gnome-shell
      gnome-magic-window =
        super.pkgs.callPackage ./pkgs/gnome-magic-window.nix { };

      # Adds support for ZSH completions - PR hasn't made it to stable channel yet
      handlr = super.pkgs.callPackage ./pkgs/handlr.nix { };

      kargos = super.pkgs.callPackage ./pkgs/kargos.nix {
        inherit (super.pkgs.plasma5Packages) plasma-framework;
      };
    })
  ];

  # Create a list of all installed packages
  # Useful for inspecting system, debugging, etc.
  environment.etc."current-system-packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in formatted;

  # Fix external monitor resolution
  boot.kernelParams = [ "video=VGA-1:1920x1080@60" ];

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
    # pkgs.iosevka
    # pkgs.powerline-fonts
  ];

  security.sudo.wheelNeedsPassword = false;

  # Include ~/bin in the path
  environment.homeBinInPath = true;

  # Network Manager
  networking.networkmanager.enable = true;
  # This fixes wifi connection failures on my machine
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
  # programs.fish.enable = true;

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
