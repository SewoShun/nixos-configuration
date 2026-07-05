{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.mcp";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
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
}
