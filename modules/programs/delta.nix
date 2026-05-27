{ delib, pkgs, ... }:
delib.module {
  name = "programs.delta";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.environment.defaultPackages = with pkgs; [ delta ];

  home.ifEnabled.programs.delta.enable = true;
}
