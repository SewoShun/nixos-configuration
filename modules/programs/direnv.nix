{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.direnv;
  inherit (config.my.constants) username;
in
{
  options.my.programs.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      stdlib = ''
        declare -A direnv_layout_dirs
        direnv_layout_dir() {
          echo /tmp/direnv/$(pwd | base64)
        }
      '';
    };
  };
}
