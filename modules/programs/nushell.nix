{
  delib,
  lib,
  pkgs,
  hostName,
  ...
}:
delib.module {
  name = "programs.nushell";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.programs.nushell.enable = true;

  home.ifEnabled.programs.nushell = {
    enable = true;
    extraConfig = ''
      ${lib.getExe pkgs.fastfetch}
    '';
    settings = {
      show_banner = false;
    };
    shellAliases =
      let
        rice = "catppuccin-mocha";
      in
      {
        nh-osl = "nh os switch ~/ghq/github.com/SewoShun/nixos-configuration -H ${hostName}-${rice}";
        nh-obl = "nh os boot ~/ghq/github.com/SewoShun/nixos-configuration -H ${hostName}-${rice}";
        nh-osr = "nh os switch github:SewoShun/nixos-configuration -H ${hostName}-${rice}";
        nh-obr = "nh os boot github:SewoShun/nixos-configuration -H ${hostName}-${rice}";
      };
  };
}
