{
  delib,
  lib,
  pkgs,
  hostName,
  ...
}:
delib.module {
  name = "programs.fish";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.programs.fish.enable = true;

  home.ifEnabled = {
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
}
