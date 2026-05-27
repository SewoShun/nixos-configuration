{ delib, ... }:
delib.module {
  name = "programs.alacritty";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
      };
      font = {
        normal = {
          family = "ZedMono Nerd Font";
          style = "Regular";
        };
      };
      mouse = {
        hide_when_typing = true;
      };
    };
  };
}
