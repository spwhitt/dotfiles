{ config, pkgs, ... }:

{
  # Attempting to get working backlight controls on all monitors
  # External, laptop, etc.
  #
  # Current status:
  # - Laptop screen works great using Brillo
  # - External monitor WORKED, (through ddci) then suddenly stopped
  #
  # Would really like to figure out how to get ddcci driver working again, it's
  # clearly the best way, but ddcutil won't even talk to the monitor anymore.

  # For laptop backlight
  # boot.kernelParams = [ "acpi_backlight=vendor" ];

  boot.kernelModules = [
    # For ddcutil to control external monitor settings (backlight, color...)
    "i2c_dev"
    "i2c-dev"

    # Expose external monitors through sysfs
    # This allows brillo to control their backlight
    # "ddcci"
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    # Package for ddci-driver enabled above
    # ddcci-driver
  ];

  # Backlight Tool (fantastic)
  hardware.brillo.enable = true;

  # Required to use brillo without root
  users.extraUsers.swhitt.extraGroups = [ "video" ];

  environment.systemPackages = [
    # Control external monitors - not working with my monitor anymore, idk why
    pkgs.ddcutil
  ];
}
