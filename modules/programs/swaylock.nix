{ delib, ... }:
delib.module {
  name = "programs.swaylock";

  options = delib.singleEnableOption false;

  # swaylock authenticates via PAM; without fprintd so that the password works immediately
  nixos.ifEnabled.security.pam.services.swaylock.fprintAuth = false;

  home.ifEnabled =
    { myconfig, ... }:
    {
      programs.swaylock = {
        enable = true;
        settings = {
          image = myconfig.constants.wallpaper;
          scaling = "fill";
        };
      };
    };
}
