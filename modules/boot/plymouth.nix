{ delib, pkgs, ... }:
delib.module {
  name = "boot.plymouth";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    boot = {
      plymouth = {
        enable = true;
        theme = "circle_hud";
        themePackages = [
          (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "circle_hud" ]; })
        ];
      };

      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "udev.log_level=3"
      ];
    };

    # conflicts with boot.plymouth.theme above
    catppuccin.plymouth.enable = false;
  };
}
