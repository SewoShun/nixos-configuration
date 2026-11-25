{
  config,
  lib,
  ...
}:
let
  cfg = config.my.hardware.laptop;
in
{
  options.my.hardware.laptop.enable = lib.mkEnableOption "laptop";

  config = lib.mkIf cfg.enable {
    my = {
      services = {
        swayidle.enable = config.my.programs.niri.enable && config.my.programs.swaylock.enable;
        tlp.enable = true;
        upower.enable = true;
      };
    };

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
