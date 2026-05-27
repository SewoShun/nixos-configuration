{ delib, pkgs, ... }:
delib.module {
  name = "programs.fd";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.environment.defaultPackages = with pkgs; [ fd ];

  home.ifEnabled.programs.fd.enable = true;
}
