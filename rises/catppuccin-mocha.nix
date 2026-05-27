{ delib, ... }:
delib.rice {
  name = "catppuccin-mocha";

  myconfig.catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
