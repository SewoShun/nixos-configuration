{ delib, ... }:
delib.module {
  name = "programs.nh";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.programs.nh.enable = true;

  home.ifEnabled.programs.nh.enable = true;
}
