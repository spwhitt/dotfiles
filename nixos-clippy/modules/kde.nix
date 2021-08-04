{ config, pkgs, ... }:

{
  # Fix conflicting definition
  programs.ssh.askPassword =
    pkgs.lib.mkForce "${pkgs.plasma5Packages.ksshaskpass.out}/bin/ksshaskpass";

  # KDE Connect
  networking.firewall.allowedTCPPortRanges = [{
    from = 1714;
    to = 1716;
  }];
  networking.firewall.allowedUDPPortRanges = [{
    from = 1714;
    to = 1716;
  }];

  services.xserver = {
    enable = true;
    layout = "us";

    xkbOptions = "caps:super";

    # Touch pad settings
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    displayManager.sddm.enable = true;

    desktopManager.plasma5.enable = true;

    # Add a session for plasma wayland
    # displayManager.sessionPackages = [
    #   (pkgs.plasma-workspace.overrideAttrs
    #     (old: { passthru.providedSessions = [ "plasmawayland" ]; }))
    # ];

    # desktopManager.plasma5.runUsingSystemd = true;

  };

  environment.systemPackages = with pkgs; [
    ww-run-raise
    kargos

    # skanlite
  ];
}
