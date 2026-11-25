{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.eza;
  inherit (config.my.constants) username;
in
{
  options.my.programs.eza.enable = lib.mkEnableOption "eza";

  config = lib.mkIf cfg.enable {
    environment.defaultPackages = [ pkgs.eza ];

    home-manager.users.${username}.programs.eza = {
      enable = true;
      icons = "auto";
      colors = "auto";
      git = true;
    };
  };
}
