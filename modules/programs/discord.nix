{ delib, ... }:
delib.module {
  name = "programs.discord";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.discord.enable = true;
}
