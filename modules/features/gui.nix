{ delib, pkgs, ... }:
delib.module {
  name = "features.gui";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    services = {
      awww.enable = true;
      dunst.enable = true;
      fcitx5.enable = true;
      kmscon.enable = true;
      lemurs.enable = true;
      yaskkserv2.enable = true;
    };

    programs = {
      alacritty.enable = true;
      discord.enable = true;
      firefox.enable = true;
      gamemode.enable = true;
      niri.enable = true;
      noctalia-shell.enable = true;
      steam.enable = true;
    };
  };

  home.ifEnabled.home.packages = with pkgs; [
    chromium
    krusader
    slack
    tor-browser
    (prismlauncher.override {
      additionalLibs = with pkgs; [
        atk
        cairo
        cups.lib
        dbus.lib
        expat
        glib
        libdrm
        libgbm
        libxcb
        libxcomposite
        libxdamage
        libxfixes
        libxkbcommon
        nspr
        nss
        pango
      ];
    })
  ];
}
