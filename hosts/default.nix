{ nixpkgs, ... }@inputs:
let
  # NixOS system wrapper — every host gets the shared modules + users.
  nixosSystem =
    { modules }:
    nixpkgs.lib.nixosSystem {
      modules = modules ++ [
        ../modules/default.nix
        ../users/module.nix
      ];
      specialArgs = { inherit inputs; };
    };
in
{
  # GEEKOM Mini PC IT12 (Intel 12th-gen, 32GB, 1TB) — dual-boots Windows 11
  sharktopus = nixosSystem {
    modules = [ sharktopus/configuration.nix ];
  };
}
