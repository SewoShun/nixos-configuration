{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.fd;
  inherit (config.my.constants) username;
in
{
  options.my.programs.fd.enable = lib.mkEnableOption "fd";

  config = lib.mkIf cfg.enable {
    environment.defaultPackages = with pkgs; [ fd ];

    home-manager.users.${username}.programs.fd.enable = true;
  };
}
