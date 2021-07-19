{ config, pkgs, ... }: {
  environment.systemPackages = [ pkgs.google-drive-ocamlfuse ];

  # systemd.services.google-drive-ocamlfuse = {
  #   user = "";
  #   group = "";
  #   description = "Google Drive FUSE filesystem";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network.target" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -label ~/GoogleDrive";
  #     ExecStop = "fusermount -u ~/GoogleDrive";
  #     Restart = "always";
  #     Type = "forking";
  #   };
  # }

  systemd.user.services.google-drive-ocamlfuse = {
    description = "Google Drive FUSE filesystem";
    wantedBy = [ "default.target" ];
    # after = [ "network.target" ];
    serviceConfig = {
      ExecStart =
        "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse /home/swhitt/GoogleDrive";
      ExecStop = "fusermount -u /home/swhitt/GoogleDrive";
      Restart = "always";
      Type = "forking";
    };
  };
}
