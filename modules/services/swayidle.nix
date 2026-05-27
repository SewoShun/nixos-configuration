{
  delib,
  lib,
  pkgs,
  homeConfig,
  ...
}:
delib.module {
  name = "services.swayidle";

  options = delib.singleEnableOption false;

  home.ifEnabled.services.swayidle =
    let
      bctl = "${lib.getExe pkgs.brightnessctl}";
      niri = "${lib.getExe homeConfig.programs.niri.package}";
      lock = "${lib.getExe homeConfig.programs.noctalia-shell.package} ipc call lockScreen lock";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 60;
          command = "${bctl} -s; ${bctl} set 0";
          resumeCommand = "${bctl} -r";
        }
        {
          timeout = 120;
          command = "${lock}";
        }
        {
          timeout = 180;
          command = "${niri} msg action power-off-monitors";
          resumeCommand = "${niri} msg action power-on-monitors";
        }
        {
          timeout = 1800;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events.before-sleep = "${lock}";
    };
}
