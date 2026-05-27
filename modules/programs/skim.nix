{ delib, ... }:
delib.module {
  name = "programs.skim";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.programs.skim.enable = true;

  home.ifEnabled.programs.skim.enable = true;
}
