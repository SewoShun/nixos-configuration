{ delib, ... }:
delib.module {
  name = "programs.rio";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.rio = {
    enable = true;
    settings = {
      fonts = {
        family = "VictorMono Nerd Font";
        size = 16;
      };
      hide-mouse-cursor-when-typing = true;
      window.decorations = "Disabled";
    };
  };
}
