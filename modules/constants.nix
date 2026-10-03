{ delib, pkgs, ... }:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "sewo");
    # shared by awww (niri startup) and swaylock
    wallpaper = readOnly (
      strOption pkgs.nixos-artwork.wallpapers.nineish-catppuccin-mocha-alt.gnomeFilePath
    );
  };
}
