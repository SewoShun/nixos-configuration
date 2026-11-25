{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.my.services.flatpak;
  inherit (config.my.constants) username;
in
{
  options.my.services.flatpak.enable = lib.mkEnableOption "flatpak";

  config = lib.mkMerge [
    {
      home-manager.users.${username}.imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];
    }
    (lib.mkIf cfg.enable {
      home-manager.users.${username}.services.flatpak.enable = true;
    })
  ];
}
