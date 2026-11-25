{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.fish;
  inherit (config.my.constants) username;
  hostName = config.networking.hostName;
in
{
  options.my.programs.fish.enable = lib.mkEnableOption "fish";

  config = lib.mkIf cfg.enable {
    programs.fish.enable = true;

    home-manager.users.${username} = {
      programs.fish = {
        enable = true;
        functions = {
          fish_greeting = "${lib.getExe pkgs.fastfetch}";
        };
        shellAbbrs =
          let
            rice = "catppuccin-mocha";
          in
          {
            osl = {
              command = "nh";
              expansion = "os switch ~/ghq/github.com/SewoShun/nixos-configuration -H ${hostName}-${rice}";
            };
            obl = {
              command = "nh";
              expansion = "os boot ~/ghq/github.com/SewoShun/nixos-configuration -H ${hostName}-${rice}";
            };
            osr = {
              command = "nh";
              expansion = "os switch github:SewoShun/nixos-configuration -H ${hostName}-${rice}";
            };
            obr = {
              command = "nh";
              expansion = "os boot github:SewoShun/nixos-configuration -H ${hostName}-${rice}";
            };
          };
      };

      xdg.configFile."fish/completions/nix.fish" = {
        source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";
      };
    };
  };
}
