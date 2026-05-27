{ delib, lib, ... }:
delib.module {
  name = "programs.zellij";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.zellij = {

    enable = true;
    settings = {
      mouse_mode = false;
      pane_frames = false;
      show_startup_tips = false;
      default_mode = "locked";
      keybinds = {
        normal._children = [
          {
            bind = {
              _args = [ "Esc" ];
              _children = [ { SwitchToMode = "locked"; } ];
            };
          }
          {
            bind = {
              _args = [ "p" ];
              _children = [ { GoToPreviousTab = { }; } ];
            };
          }
          {
            bind = {
              _args = [ "n" ];
              _children = [ { GoToNextTab = { }; } ];
            };
          }
          {
            bind = {
              _args = [ "N" ];
              _children = [ { NewTab = { }; } ];
            };
          }
          {
            bind = {
              _args = [ "x" ];
              _children = [ { CloseTab = { }; } ];
            };
          }
        ]
        ++ (map (i: {
          bind = {
            _args = [ (toString i) ];
            _children = [ { GoToTab = i; } ];
          };
        }) (lib.lists.range 1 9));
        shared_except = {
          _args = [ "locked" ];
          _children = [
            {
              bind = {
                _args = [ "Alt p" ];
                _children = [ { GoToPreviousTab = { }; } ];
              };
            }
            {
              bind = {
                _args = [ "Alt n" ];
                _children = [ { GoToNextTab = { }; } ];
              };
            }
          ]
          ++ (map (i: {
            bind = {
              _args = [ "Alt ${toString i}" ];
              _children = [ { GoToTab = i; } ];
            };
          }) (lib.lists.range 1 9));
        };
      };
    };
  };
}
