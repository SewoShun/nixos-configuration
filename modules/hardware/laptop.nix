{ delib, ... }:
delib.module {
  name = "hardware.laptop";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled =
    { myconfig, ... }:
    {
      services = {
        swayidle.enable = myconfig.programs.niri.enable && myconfig.programs.noctalia-shell.enable;
        tlp.enable = true;
        upower.enable = true;
      };
    };

  nixos.ifEnabled = {
    services = {
      logind.settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandlePowerKey = "sleep";
        HandlePowerKeyLongPress = "hibernate";
      };

      thermald.enable = true;
    };
  };
}
