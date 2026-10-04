{
  delib,
  homeConfig,
  lib,
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
      workspacesListener = import ../../lib/eww-workspaces.nix {
        inherit pkgs;
        niri = homeConfig.programs.niri.package;
      };
      volumeListener = import ../../lib/eww-volume.nix { inherit pkgs; };
      brightnessListener = import ../../lib/eww-brightness.nix { inherit pkgs; };
      networkListener = import ../../lib/eww-network.nix { inherit pkgs; };
      # the display marked primary, or the first one when none is marked
      primaryMonitor =
        let
          displays = myconfig.host.displays;
        in
        lib.findFirst (display: display.primary) (lib.head displays) displays;
      openBars = import ../../lib/eww-bar.nix {
        inherit pkgs;
        eww = homeConfig.programs.eww.package;
      };
    in
    {
      programs.eww = {
        enable = true;
        systemd.enable = true;
      };

      systemd.user.services.eww.Service = {
        # restart the daemon when it is killed or crashes
        Restart = "always";
        RestartSec = 1;
        # windows die with the daemon, so the bars are opened on every start
        # (login, crash, switch) rather than once from niri's startup
        ExecStartPost = lib.getExe openBars;
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
          # one bar is opened per monitor
          monitors = map (display: display.name) myconfig.host.displays;
          # the system tray is shown only on this monitor's bar
          primaryMonitor = primaryMonitor.name;
        };
        # listeners run scripts from the Nix store, so their paths are generated
        "eww/listeners.yuck".text = ''
          (deflisten workspaces :initial "{}" "${lib.getExe workspacesListener}")
          (deflisten volume :initial "{}" "${lib.getExe volumeListener}")
          (deflisten brightness :initial "0" "${lib.getExe brightnessListener}")
          (deflisten network :initial "{}" "${lib.getExe networkListener}")
        '';
      };
    };
}
