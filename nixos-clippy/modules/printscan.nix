{ config, pkgs, ... }: {
  # Allow service discovery e.g. network printers
  services.avahi.enable = false;
  services.avahi.nssmdns = false;
  # services.avahi.publish.enable = true;
  # services.avahi.publish.userServices = true;

  # services.samba.enable = true;
  services.printing.enable = true;
  services.printing.browsing = true;
  # services.printing.drivers = [ pkgs.gutenprint pkgs.brlaser ];
  services.printing.drivers = [ pkgs.brlaser ];

  # Scanning support
  hardware.sane.enable = true;
  hardware.sane.brscan4 = {
    enable = true;
    netDevices.office = {
      ip = "192.168.0.113";
      model = "DCP-L2540DW";
    };
  };

  users.extraUsers.swhitt.extraGroups = [ "scanner" "lp" ];
}
