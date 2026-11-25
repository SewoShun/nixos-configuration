{ lib, pkgs, ... }:
{
  options.my.constants = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "sewo";
      readOnly = true;
    };
    # shared by awww (niri startup) and swaylock
    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = pkgs.nixos-artwork.wallpapers.nineish-catppuccin-mocha-alt.gnomeFilePath;
      readOnly = true;
    };
  };
}
