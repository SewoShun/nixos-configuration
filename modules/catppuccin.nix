{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.my.catppuccin;
  inherit (config.my.constants) username;
in
{
  imports = [ inputs.catppuccin.nixosModules.catppuccin ];

  options.my.catppuccin = {
    enable = lib.mkEnableOption "catppuccin";
    flavor = lib.mkOption {
      type = lib.types.enum [
        "latte"
        "frappe"
        "macchiato"
        "mocha"
      ];
      default = "mocha";
    };
  };

  config = lib.mkMerge [
    {
      home-manager.users.${username}.imports = [ inputs.catppuccin.homeModules.catppuccin ];
    }
    (lib.mkIf cfg.enable {
      catppuccin = {
        enable = true;
        autoEnable = true;
        inherit (cfg) flavor;
        cache.enable = true;
      };

      home-manager.users.${username}.catppuccin = {
        enable = true;
        autoEnable = true;
        inherit (cfg) flavor;
        cursors.enable = true;
        cache.enable = true;
      };
    })
  ];
}
