{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.features.nix-enhancement;
  inherit (config.my.constants) username;
in
{
  options.my.features.nix-enhancement.enable = lib.mkEnableOption "nix-enhancement";

  config = lib.mkIf cfg.enable {
    my = {
      services.angrr.enable = true;

      programs = {
        nh.enable = true;
        nix-index.enable = true;
      };
    };

    home-manager.users.${username}.home.packages = with pkgs; [ manix ];
  };
}
