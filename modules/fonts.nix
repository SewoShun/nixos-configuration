{
  pkgs,
  ...
}:
{
  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    dejavu_fonts
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    ipaexfont
    migu
    nerd-fonts.zed-mono
    nerd-fonts."m+"
    nerd-fonts.victor-mono
    nerd-fonts.monaspace
  ];
}
