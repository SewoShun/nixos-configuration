{ delib, ... }:
delib.module {
  name = "programs.yazi";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.programs.yazi.enable = true;

  home.ifEnabled.programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
  };
}
