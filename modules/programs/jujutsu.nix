{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.jujutsu;
  inherit (config.my.constants) username;
in
{
  options.my.programs.jujutsu.enable = lib.mkEnableOption "jujutsu";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "93058265+SewoShun@users.noreply.github.com";
          name = "SewoShun";
        };
      };
    };
  };
}
