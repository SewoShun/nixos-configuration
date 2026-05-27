{ delib, ... }:
delib.module {
  name = "programs.jujutsu";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "93058265+SewoShun@users.noreply.github.com";
        name = "SewoShun";
      };
    };
  };
}
