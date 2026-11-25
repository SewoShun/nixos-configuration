{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.delta;
  inherit (config.my.constants) username;
in
{
  options.my.programs.delta.enable = lib.mkEnableOption "delta";

  config = lib.mkIf cfg.enable {
    environment.defaultPackages = with pkgs; [ delta ];

    home-manager.users.${username}.programs.delta.enable = true;
  };
}
