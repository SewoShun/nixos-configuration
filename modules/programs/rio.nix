{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.rio;
  inherit (config.my.constants) username;
  homeConfig = config.home-manager.users.${username};
in
{
  options.my.programs.rio.enable = lib.mkEnableOption "rio";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.rio = {
      enable = true;
      settings = {
        fonts = {
          family = "VictorMono Nerd Font";
          size = 16;
        };
        hide-mouse-cursor-when-typing = true;
        shell.program = lib.getExe homeConfig.programs.nushell.package;
        window.decorations = "Disabled";
      };
    };
  };
}
