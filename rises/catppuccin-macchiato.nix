{ delib, ... }:
delib.rice {
  name = "catppuccin-macchiato";

  myconfig.catppuccin = {
    enable = true;
    flavor = "macchiato";
  };
}
