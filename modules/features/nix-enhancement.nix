{ delib, pkgs, ... }:
delib.module {
  name = "features.nix-enhancement";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    services.angrr.enable = true;

    programs = {
      nh.enable = true;
      nix-index.enable = true;
    };
  };

  home.ifEnabled.home.packages = with pkgs; [ manix ];
}
