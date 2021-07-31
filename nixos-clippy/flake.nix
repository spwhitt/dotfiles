{
  # Use local checkout which has plasma systemd pr incorporated
  # inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  inputs.nixpkgs.url = "/home/swhitt/.dotfiles/deps/nixpkgs";

  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {

    nixosConfigurations.clippy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [ ./configuration.nix
          ({ pkgs, ... }: {
            # boot.isContainer = true;

            # Let 'nixos-version --json' know about the Git revision
            # of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;

            # Pin the nixpkgs flake to the system version
            nix.registry.nixpkgs.flake = nixpkgs;
          })
        ];
    };
  };
}
