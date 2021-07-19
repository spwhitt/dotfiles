{ config, pkgs, ... }:

{
  # Fix bluetooth intermittent disconnects
  # TODO: remove on upgrade to next stable release
  # hardware.firmware = with pkgs; [
  #   (firmwareLinuxNonfree.overrideAttrs (oldAttrs: rec {
  #     outputHash = "sha256-97dh9N6KHmK1TfMU0EaNPfZ1Mx7zm/Y3lAfASUSxzXM=";
  #     src = pkgs.fetchgit {
  #       url = "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git";
  #       rev = "73144e02dcff54529ab42d951de682740d204180";
  #       sha256 = "sha256-6VYtF7MbsCcPFmmOJCapQs9kHZNPRQ9HFZBhTaE2ecE=";
  #     };
  #   }))
  # ];

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;

    # Prototype implementation for connecting to HSP/HFP devices
    # hsphfpd.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    # alsa.support32Bit = true;
  };
  hardware.pulseaudio.enable = false;

  # Bluetooth gui
  # services.blueman.enable = true;
}
