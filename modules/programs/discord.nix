{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.discord;
  inherit (config.my.constants) username;
in
{
  options.my.programs.discord.enable = lib.mkEnableOption "discord";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.discord.enable = true;
  };
}
