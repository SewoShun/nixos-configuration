{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.bat;
  inherit (config.my.constants) username;
in
{
  options.my.programs.bat.enable = lib.mkEnableOption "bat";

  config = lib.mkIf cfg.enable {
    programs.bat.enable = true;

    home-manager.users.${username}.programs.bat.enable = true;
  };
}
