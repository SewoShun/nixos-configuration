{ delib, pkgs, ... }:
delib.module {
  name = "services.kmscon";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.services.kmscon = {
    enable = true;
    fonts = [
      {
        name = "M+1Code Nerd Font";
        package = pkgs.nerd-fonts."m+";
      }
    ];
  };
}
