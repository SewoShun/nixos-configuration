{ delib, pkgs, ... }:
delib.module {
  name = "programs.eza";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.environment.defaultPackages = [ pkgs.eza ];

  home.ifEnabled.programs.eza = {
    enable = true;
    icons = "auto";
    colors = "auto";
    git = true;
  };
}
