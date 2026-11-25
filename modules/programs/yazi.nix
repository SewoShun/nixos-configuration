{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.yazi;
  inherit (config.my.constants) username;
in
{
  options.my.programs.yazi.enable = lib.mkEnableOption "yazi";

  config = lib.mkIf cfg.enable {
    programs.yazi.enable = true;

    home-manager.users.${username}.programs.yazi = {
      enable = true;
      shellWrapperName = "yy";
    };
  };
}
