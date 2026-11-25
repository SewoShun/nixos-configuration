{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.git;
  inherit (config.my.constants) username;
in
{
  options.my.programs.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf cfg.enable {
    programs.git.enable = true;

    home-manager.users.${username}.programs.git = {
      enable = true;
      settings.user = {
        email = "93058265+SewoShun@users.noreply.github.com";
        name = "SewoShun";
      };
    };
  };
}
