{ delib, inputs, ... }:
delib.module {
  name = "catppuccin";

  options =
    with delib;
    moduleOptions {
      enable = boolOption false;
      flavor = enumOption [ "latte" "frappe" "macchiato" "mocha" ] "mocha";
    };

  nixos.always.imports = [ inputs.catppuccin.nixosModules.catppuccin ];

  nixos.ifEnabled =
    { cfg, ... }:
    {
      catppuccin = {
        enable = true;
        inherit (cfg) flavor;
      };
    };

  home.always.imports = [ inputs.catppuccin.homeModules.catppuccin ];

  home.ifEnabled =
    { cfg, ... }:
    {
      catppuccin = {
        enable = true;
        inherit (cfg) flavor;
        cursors.enable = true;
      };
    };
}
