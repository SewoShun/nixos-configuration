{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.claude-code;
  inherit (config.my.constants) username;
in
{
  options.my.programs.claude-code.enable = lib.mkEnableOption "claude-code";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs = {
      claude-code = {
        enable = true;
        enableMcpIntegration = true;
      };
    };
  };
}
