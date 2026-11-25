{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.skim;
  inherit (config.my.constants) username;
in
{
  options.my.programs.skim.enable = lib.mkEnableOption "skim";

  config = lib.mkIf cfg.enable {
    programs.skim.enable = true;

    home-manager.users.${username}.programs.skim.enable = true;
  };
}
