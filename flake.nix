{
  description = "My nix configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Hardware quirks
    hardware.url = "github:nixos/nixos-hardware";

  
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs ["aarch64-linux" "x86_64-linux"];
    inherit (self) outputs;
  in rec {

    # Devshell for bootstrapping
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      import ./shell.nix {inherit pkgs;});

    nixosConfigurations = {
      # laptop Server
      mrtuxa-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        }; # Pass flake inputs to our config
        modules = [./hosts/laptop];
      };
      # Desktop Computer
      mrtuxa-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        }; # Pass flake inputs to our config
        modules = [./hosts/desktop];
      };
    };
  };
}