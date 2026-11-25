{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.nushell;
  inherit (config.my.constants) username;
  hostName = config.networking.hostName;
in
{
  options.my.programs.nushell.enable = lib.mkEnableOption "nushell";

  config = lib.mkIf cfg.enable {
    programs.nushell.enable = true;

    home-manager.users.${username}.programs.nushell = {
      enable = true;
      extraConfig = ''
        ${lib.getExe pkgs.fastfetch}
      '';
      settings = {
        show_banner = false;
      };
      shellAliases = {
        nh-osl = "nh os switch ~/ghq/github.com/SewoShun/nixos-configuration -H ${hostName}";
        nh-obl = "nh os boot ~/ghq/github.com/SewoShun/nixos-configuration -H ${hostName}";
        nh-osr = "nh os switch github:SewoShun/nixos-configuration -H ${hostName}";
        nh-obr = "nh os boot github:SewoShun/nixos-configuration -H ${hostName}";
      };
    };
  };
}
