{ delib, ... }:
delib.module {
  name = "programs.zed-editor";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.zed-editor = {
    enable = true;
    userSettings = {
      helix_mode = true;
      buffer_font_family = "VictorMono Nerd Font";
      terminal.font_family = "VictorMono Nerd Font";
    };
  };
}
