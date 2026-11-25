{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.my.programs.nix-index;
  inherit (config.my.constants) username;
in
{
  imports = [
    inputs.nix-index-database.nixosModules.default
  ];

  options.my.programs.nix-index.enable = lib.mkEnableOption "nix-index";

  config = lib.mkMerge [
    {
      home-manager.users.${username}.imports = [ inputs.nix-index-database.homeModules.default ];
    }
    (lib.mkIf cfg.enable {
      programs = {
        nix-index.enable = true;
        nix-index-database.comma.enable = true;
      };

      home-manager.users.${username}.programs = {
        nix-index.enable = true;
        nix-index-database.comma.enable = true;
      };
    })
  ];
}
