{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.firefox;
  inherit (config.my.constants) username;
  homeConfig = config.home-manager.users.${username};
in
{
  options.my.programs.firefox.enable = lib.mkEnableOption "firefox";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.firefox = {
      enable = true;
      languagePacks = [
        "en"
        "ja"
      ];
      configPath = "${homeConfig.xdg.configHome}/mozilla/firefox";
    };
  };
}
