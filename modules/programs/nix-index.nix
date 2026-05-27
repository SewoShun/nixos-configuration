{ delib, inputs, ... }:
delib.module {
  name = "programs.nix-index";

  options = delib.singleEnableOption false;

  nixos.always.imports = [ inputs.nix-index-database.nixosModules.default ];

  nixos.ifEnabled.programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
  };

  home.always.imports = [ inputs.nix-index-database.homeModules.default ];

  home.ifEnabled.programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
  };
}
