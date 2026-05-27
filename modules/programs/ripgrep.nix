{ delib, pkgs, ... }:
delib.module {
  name = "programs.ripgrep";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.environment.defaultPackages = with pkgs; [
    ripgrep
    ripgrep-all
  ];

  home.ifEnabled.programs = {
    ripgrep.enable = true;
    ripgrep-all.enable = true;
  };
}
