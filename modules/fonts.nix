{ delib, pkgs, ... }:
delib.module {
  name = "fonts";

  nixos.always.fonts.packages = with pkgs; [
    ipaexfont
    migu
    nerd-fonts.zed-mono
    nerd-fonts."m+"
  ];
}
