{
  description = "nixos-btw";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hanabi-src = {
      url = "github:jeffshee/gnome-ext-hanabi";
      flake = false;
    };
  };
 #hababie ist live background
  outputs =
    {
      self,
      nixpkgs,
      zen-browser,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit zen-browser;

        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
           home-manager.useGlobalPkgs =true;
           home-manager.useUserPackages = true;

           home-manager.users.andre = import ./home.nix;

            }
        ];
      };
    };
}
