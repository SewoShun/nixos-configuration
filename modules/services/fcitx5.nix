{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "services.fcitx5";

  options =
    with delib;
    moduleOptions {
      enable = boolOption false;
      skk.enable = boolOption true;
    };

  home.ifEnabled =
    { cfg, ... }:
    {
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 =
          let
            base = {
              waylandFrontend = true;
              settings = {
                globalOptions = {
                  Hotkey = {
                    "TriggerKeys/0" = "Super+space";
                    AltTriggerKeys = "";
                  };
                };
                inputMethod = {
                  GroupOrder."0" = "Default";
                  "Groups/0" = {
                    Name = "Default";
                    "Default Layout" = "us";
                  };
                  "Groups/0/Items/0".Name = "keyboard-us";
                };
                addons.skk.globalSection = {
                  Rule = "azik";
                  InitialInputMode = "Latin";
                  EggLikeNewLine = true;
                };
              };
            };

            skk = {
              addons = [ pkgs.fcitx5-skk ];
              settings = {
                inputMethod = {
                  "Groups/0".DefaultIM = "skk";
                  "Groups/0/Items/1".Name = "skk";
                };
                addons.skk.globalSection = {
                  Rule = "azik";
                  InitialInputMode = "Latin";
                  EggLikeNewLine = true;
                };
              };
            };
          in
          lib.recursiveUpdate base (if cfg.skk.enable then skk else { });
      };

      xdg.dataFile."fcitx5/skk/dictionary_list" = {
        enable = cfg.skk.enable;
        text = ''
          type=server,host=localhost,port=1178,encoding=EUC-JP
        '';
      };
    };
}
