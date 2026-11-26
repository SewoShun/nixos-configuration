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
          family = "MonaspiceNe NF";
          size = 16;
          features = [
            "calt"
            "-ss01"
            "-ss02"
            "-ss03"
            "-ss04"
            "-ss05"
            "-ss06"
            "-ss07"
            "-ss08"
            "-ss09"
            "-ss10"
            "-liga"
          ];
        };
        hide-mouse-cursor-when-typing = true;
        shell.program = lib.getExe homeConfig.programs.nushell.package;
        window.decorations = "Disabled";
      };
    };
  };
}
