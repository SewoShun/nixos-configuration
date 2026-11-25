{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.starship;
  inherit (config.my.constants) username;
in
{
  options.my.programs.starship.enable = lib.mkEnableOption "starship";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings = {
        env_var = {
          GHQ_LOOK = {
            format = "ghq look: [$env_value]($style) ";
          };
        };
        custom.jj = {
          command = "prompt";
          format = "$output";
          ignore_timeout = true;
          shell = [
            "${pkgs.starship-jj}/bin/starship-jj"
            "--ignore-working-copy"
            "starship"
          ];
          use_stdin = false;
          when = true;
        };
      };
    };
  };
}
