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
        overviewEnabled = false;
      };
      colorSchemes.predefinedScheme = "Catppuccin";
    };
  };
}
