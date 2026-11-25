{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    claude-desktop.url = "github:patrickjaja/claude-desktop-extra";
    claude-desktop.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs";
    xremap.url = "github:xremap/nix-flake";
    xremap.inputs.nixpkgs.follows = "nixpkgs";
    yaskkserv2-nix.url = "github:SewoShun/yaskkserv2-nix";
    yaskkserv2-nix.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      inherit (nixpkgs) lib;

      nixFilesIn = dir: lib.filter (lib.hasSuffix ".nix") (lib.filesystem.listFilesRecursive dir);

      mkHost =
        hostName:
        lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules =
            nixFilesIn ./hosts/${hostName}
            ++ nixFilesIn ./modules
            ++ nixFilesIn ./overlays
            ++ [ home-manager.nixosModules.home-manager ];
        };
    in
    {
      nixosConfigurations = lib.genAttrs [
        "desktop"
        "thinkpad-e14-gen7"
      ] mkHost;
    };
}
