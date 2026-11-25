{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.gh;
  inherit (config.my.constants) username;
in
{
  options.my.programs.gh.enable = lib.mkEnableOption "gh";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      extensions = with pkgs; [
        gh-s
      ];
    };
  };
}
