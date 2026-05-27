{ delib, ... }:
delib.module {
  name = "xdg-portal";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };

  home.ifEnabled.xdg.portal.enable = true;
}
