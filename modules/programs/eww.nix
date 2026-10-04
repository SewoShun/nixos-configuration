{
  delib,
  homeConfig,
  pkgs,
  ...
}:
delib.module {
  name = "programs.eww";

  options = delib.singleEnableOption false;

  home.ifEnabled =
    { myconfig, ... }:
    let
      palette = import ../../lib/catppuccin-palette.nix { inherit (pkgs) lib; } {
        palette = homeConfig.catppuccin.sources.palette;
        inherit (myconfig.catppuccin) flavor;
      };
    in
    {
      programs.eww = {
        enable = true;
        systemd.enable = true;
      };

      # restart the daemon when it is killed or crashes
      systemd.user.services.eww.Service = {
        Restart = "always";
        RestartSec = 1;
      };

      # yuck and scss live in the repository as plain files; the files generated
      # from Nix (palette, host differences) are placed next to them
      xdg.configFile = {
        "eww" = {
          source = ../../config/eww;
          recursive = true;
        };
        "eww/colors.scss".text = palette.scss;
        "eww/host.json".text = builtins.toJSON {
          # hosts with a backlight and a battery
          laptop = myconfig.hardware.laptop.enable;
        };
      };
    };
}
