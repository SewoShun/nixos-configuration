{ delib, homeConfig, ... }:
delib.module {
  name = "programs.firefox";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.firefox = {
    enable = true;
    languagePacks = [
      "en"
      "ja"
    ];
    configPath = "${homeConfig.xdg.configHome}/mozilla/firefox";
  };
}
