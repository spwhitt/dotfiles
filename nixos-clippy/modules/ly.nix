{ config, pkgs, ... }:

{
  options = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable the ly display manager, a minimalist console based display manager
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ ly ];
    systemd.services.ly = {
    };
  };
}
