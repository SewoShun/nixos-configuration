{
  delib,
  homeConfig,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.wleave";

  options = delib.singleEnableOption false;

  home.ifEnabled =
    { myconfig, ... }:
    let
      swaylock = lib.getExe homeConfig.programs.swaylock.package;
      niri = lib.getExe homeConfig.programs.niri.package;
      systemctl = "${pkgs.systemd}/bin/systemctl";

      inherit (myconfig.catppuccin) flavor;
      accent = "mauve";
      wlogout = homeConfig.catppuccin.sources.wlogout;

      icons = [
        "hibernate"
        "lock"
        "logout"
        "reboot"
        "shutdown"
        "suspend"
      ];

      # label doubles as the CSS id that the icon styles below are keyed on
      button = label: keybind: action: {
        inherit label keybind action;
        text = lib.toSentenceCase label;
      };
    in
    {
      programs.wleave = {
        enable = true;
        # same as catppuccin/nix's wleave module, which is inactive while catppuccin.enable is off
        style = ''
          @import url("${wlogout}/themes/${flavor}/${accent}.css");
        ''
        + lib.concatMapStrings (icon: ''
          #${icon} {
            background-image: url("${wlogout}/icons/wleave/${flavor}/${accent}/${icon}.svg");
          }
        '') icons;
        settings = {
          buttons = [
            (button "lock" "l" "${swaylock} -f")
            (button "logout" "e" "${niri} msg action quit --skip-confirmation")
            (button "suspend" "s" "${systemctl} suspend")
          ]
          ++ lib.optional myconfig.hardware.laptop.enable (button "hibernate" "h" "${systemctl} hibernate")
          ++ [
            (button "reboot" "r" "${systemctl} reboot")
            (button "shutdown" "p" "${systemctl} poweroff")
          ];
        };
      };
    };
}
