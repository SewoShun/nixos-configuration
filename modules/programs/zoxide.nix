{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.zoxide;
  inherit (config.my.constants) username;
in
{
  options.my.programs.zoxide.enable = lib.mkEnableOption "zoxide";

  config = lib.mkIf cfg.enable {
    programs.zoxide.enable = true;

    home-manager.users.${username}.programs.zoxide.enable = true;
  };
}
