{
  delib,
  config,
  homeConfig,
  inputs,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.niri";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  home.always.imports = [ inputs.niri.homeModules.niri ];

  home.ifEnabled =
    { myconfig, ... }:
    {
      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
        settings =
          let
            alacritty = lib.getExe homeConfig.programs.alacritty.package;
            firefox = lib.getExe homeConfig.programs.firefox.package;
            zellij = lib.getExe homeConfig.programs.zellij.package;
            noctalia-shell = lib.getExe homeConfig.programs.noctalia-shell.package;
            noctalia-call =
              cmd:
              [
                noctalia-shell
                "ipc"
                "call"
              ]
              ++ (lib.splitString " " cmd);

            outputs = lib.listToAttrs (
              map (output: {
                inherit (output) name;
                value = {
                  mode = {
                    inherit (output) width height;
                    refresh = output.refreshRate * 1.0;
                  };
                  position = {
                    inherit (output) x y;
                  };
                };
              }) myconfig.host.displays
            );
          in
          {
            inherit outputs;

            binds = with homeConfig.lib.niri.actions; {
              "Mod+Return".action = spawn alacritty "--command=${zellij}";
              "Mod+b".action = spawn firefox;
              "Mod+d".action.spawn = noctalia-call "launcher toggle";
              "Mod+Shift+p".action.spawn = noctalia-call "sessionMenu toggle";
              "Mod+Comma".action.spawn = noctalia-call "settings toggle";
              "Mod+Shift+m".action.spawn = noctalia-call "systemMonitor toggle";
              "Mod+c".action.spawn = noctalia-call "calendar toggle";

              XF86MonBrightnessUp.action.spawn = noctalia-call "brightness increase";
              XF86MonBrightnessDown.action.spawn = noctalia-call "brightness decrease";
              XF86AudioRaiseVolume.action.spawn = noctalia-call "volume increase";
              XF86AudioLowerVolume.action.spawn = noctalia-call "volume decrease";
              XF86AudioMute.action.spawn = noctalia-call "volume muteOutput";

              "Mod+s".action.screenshot.show-pointer = true;
              "Mod+Shift+s".action.screenshot-window.write-to-disk = true;

              "Mod+Shift+q".action = close-window;
              "Mod+f".action = fullscreen-window;
              "Mod+Shift+f".action = toggle-window-floating;
              "Mod+m".action = maximize-column;
              "Mod+o".action = toggle-overview;
              "Mod+Minus".action = set-column-width "-5%";
              "Mod+Equal".action = set-column-width "+5%";

              "Mod+h".action = focus-column-or-monitor-left;
              "Mod+j".action = focus-window-or-workspace-down;
              "Mod+k".action = focus-window-or-workspace-up;
              "Mod+l".action = focus-column-or-monitor-right;

              "Mod+Shift+h".action = move-column-left-or-to-monitor-left;
              "Mod+Shift+j".action = move-window-down-or-to-workspace-down;
              "Mod+Shift+k".action = move-window-up-or-to-workspace-up;
              "Mod+Shift+l".action = move-column-right-or-to-monitor-right;

              "Mod+1".action = focus-workspace 1;
              "Mod+2".action = focus-workspace 2;
              "Mod+3".action = focus-workspace 3;
              "Mod+4".action = focus-workspace 4;
              "Mod+5".action = focus-workspace 5;
              "Mod+6".action = focus-workspace 6;
              "Mod+7".action = focus-workspace 7;
              "Mod+8".action = focus-workspace 8;
              "Mod+9".action = focus-workspace 9;

              "Mod+Shift+1".action = move-workspace-to-index 1;
              "Mod+Shift+2".action = move-workspace-to-index 2;
              "Mod+Shift+3".action = move-workspace-to-index 3;
              "Mod+Shift+4".action = move-workspace-to-index 4;
              "Mod+Shift+5".action = move-workspace-to-index 5;
              "Mod+Shift+6".action = move-workspace-to-index 6;
              "Mod+Shift+7".action = move-workspace-to-index 7;
              "Mod+Shift+8".action = move-workspace-to-index 8;
              "Mod+Shift+9".action = move-workspace-to-index 9;
            };

            input = {
              focus-follows-mouse.enable = true;
            };

            hotkey-overlay = {
              hide-not-bound = true;
              skip-at-startup = true;
            };

            clipboard.disable-primary = true;
            screenshot-path = "~/Pictures/Screenshots/screenshot-%Y-%m-%d-%H-%M-%S.png";

            spawn-at-startup = [
              { argv = [ noctalia-shell ]; }
              {
                argv = [
                  "fcitx5"
                  "-d"
                ];
              }
            ];

            layout = {
              focus-ring.width = 1;
              background-color = "transparent";
            };

            window-rules = [
              {
                matches = [
                  {
                    title = "nvim-ime";
                  }
                ];
                opacity = 0.9;
                open-floating = true;
                focus-ring.enable = false;
              }
            ];

            layer-rules = [
              {
                matches = [
                  {
                    namespace = "^noctalia-wallpaper*";
                  }
                ];
                place-within-backdrop = true;
              }
            ];

            overview.workspace-shadow.enable = false;

            xwayland-satellite = {
              enable = true;
              path = lib.getExe pkgs.xwayland-satellite;
            };
          };
      };
    };
}
