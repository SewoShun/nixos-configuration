{ delib, ... }:
delib.rice {
  name = "catppuccin-frappe";

  myconfig.catppuccin = {
    enable = true;
    flavor = "frappe";
  };
}
