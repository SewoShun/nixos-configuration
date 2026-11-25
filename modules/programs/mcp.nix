{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.mcp;
  inherit (config.my.constants) username;
in
{
  options.my.programs.mcp.enable = lib.mkEnableOption "mcp";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        mcp-server-filesystem
      ];
      programs.mcp = {
        enable = true;
        servers = {
          filesystem.command = pkgs.lib.getExe pkgs.mcp-server-filesystem;
        };
      };
    };
  };
}
