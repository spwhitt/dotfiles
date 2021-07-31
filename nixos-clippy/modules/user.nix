{ config, pkgs, ... }: {
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
}
