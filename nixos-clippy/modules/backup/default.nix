{ config, pkgs, ... }:

{
  # My old duplicati setup
  services.duplicati = {
    enable = true;
    # The default interface "lo" causes an error. This is the correct value
    interface = "loopback";
  };

  # Restic Backup to Backblaze
  # services.restic.backups.clippy = {
  #   paths=[ "/home" ];
  #   repository="b2:clippy-restic/";
  #   initialize=true;
  #   passwordFile="";
  #   pruneOpts=[
  #     "--keep-daily 7"
  #     "--keep-weekly 5"
  #     "--keep-monthly 12"
  #     "--keep-yearly 5"
  #   ];
  #   # timerConfig=""; default is daily
  #   extraBackupArgs=""; # exclude, include, etc.
  # };

  # Borg, if I decide not to use B2
  # services.borg.backups
}
