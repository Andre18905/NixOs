{
  description = "nixos-btw";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url= "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";

    };
    declarative-flatpak.url = "github:gmodena/nix-flatpak";
    nix-software-center = {
      url = "github:snowfallorg/nix-software-center";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      declarative-flatpak,
      nixpkgs-stable,
      nix-software-center,
      ...
    }:
    {
      nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
         
          inherit nix-software-center;
        };
        modules = [
          ./configuration.nix
          declarative-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager

          {

            nixpkgs.overlays = [
              (final: prev: {
                #niri auf stable machen
                niri = nixpkgs-stable.legacyPackages.x86_64-linux.niri;

              })
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.andre = import ./home.nix;
          }
        ];
      };
    };
}
