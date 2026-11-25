{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.nh;
  inherit (config.my.constants) username;
in
{
  options.my.programs.nh.enable = lib.mkEnableOption "nh";

  config = lib.mkIf cfg.enable {
    programs.nh.enable = true;

    home-manager.users.${username}.programs.nh.enable = true;
  };
}
