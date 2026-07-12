{
  description = "Matt's NixOS configuration";

  inputs = {
    # Current stable branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # User account / dotfile management
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Hardware-specific optimizations
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # NixOS configurations are wired up in hosts/default.nix
      nixosConfigurations = import ./hosts inputs;

      # `nix fmt` — format every .nix file with nixfmt (RFC style).
      formatter.${system} = pkgs.writeShellApplication {
        name = "fmt";
        runtimeInputs = [
          pkgs.nixfmt-rfc-style
          pkgs.findutils
        ];
        text = ''
          find . -name '*.nix' -not -path './.git/*' -exec nixfmt {} +
        '';
      };
    };
}
