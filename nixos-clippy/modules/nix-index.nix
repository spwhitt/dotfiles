{ config, pkgs, ... }: {
  # use nix-index instead of command-not-found
  programs.command-not-found.enable = false;
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
}
