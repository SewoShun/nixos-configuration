{ delib, ... }:
delib.module {
  name = "programs.git";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.programs.git.enable = true;

  home.ifEnabled.programs.git = {
    enable = true;
    settings.user = {
      email = "93058265+SewoShun@users.noreply.github.com";
      name = "SewoShun";
    };
  };
}
