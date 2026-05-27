{ delib, ... }:
delib.rice {
  name = "catppuccin-latte";

  myconfig.catppuccin = {
    enable = true;
    flavor = "latte";
  };
}
