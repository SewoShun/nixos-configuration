{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "features.gui";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    services = {
      awww.enable = true;
      dunst.enable = true;
      fcitx5.enable = true;
      kmscon.enable = true;
      greetd = {
        enable = true;
        greeter = "regreet";
      };
      yaskkserv2.enable = true;
    };

    programs = {
      anyrun.enable = true;
      discord.enable = true;
      eww.enable = true;
      firefox.enable = true;
      gamemode.enable = true;
      niri.enable = true;
      steam.enable = true;
      swaylock.enable = true;
      wezterm.enable = true;
      wleave.enable = true;
      zed-editor.enable = true;
      zen-browser.enable = true;
    };
  };

  home.ifEnabled.home.packages = with pkgs; [
    chromium
    vivify
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
    inputs.basalt-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
