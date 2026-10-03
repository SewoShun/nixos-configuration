{ delib, inputs, ... }:
delib.module {
  name = "programs.noctalia-shell";

  options = delib.singleEnableOption false;

  home.always.imports = [ inputs.noctalia-shell.homeModules.default ];

  home.ifEnabled.programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        position = "left";
      };
      wallpaper = {
        # wallpaper is set by awww
        enabled = false;
        overviewEnabled = false;
      };
      colorSchemes.predefinedScheme = "Catppuccin";
    };
  };
}
