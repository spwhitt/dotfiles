{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.dropbox ];
  systemd.user.services.dropbox = {
    description = "dropbox";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      PassEnvironment = "DISPLAY";
      Restart = "always";
      RestartSec = "5";
    };
  };
}
