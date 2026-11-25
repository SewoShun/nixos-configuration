{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.ripgrep;
  inherit (config.my.constants) username;
in
{
  options.my.programs.ripgrep.enable = lib.mkEnableOption "ripgrep";

  config = lib.mkIf cfg.enable {
    environment.defaultPackages = with pkgs; [
      ripgrep
      ripgrep-all
    ];

    home-manager.users.${username}.programs = {
      ripgrep.enable = true;
      ripgrep-all.enable = true;
    };
  };
}
