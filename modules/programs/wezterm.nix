{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.wezterm;
  inherit (config.my.constants) username;
in
{
  options.my.programs.wezterm.enable = lib.mkEnableOption "wezterm";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.wezterm = {
      enable = true;
      settings = {
        font = lib.generators.mkLuaInline ''
          wezterm.font{
            family = "VictorMono Nerd Font",
            harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
          }
        '';
        window_decorations = "NONE";
        hide_mouse_cursor_when_typing = true;
        use_fancy_tab_bar = false;

        leader = {
          key = "g";
          mods = "CTRL";
          timeout_milliseconds = 1000;
        };

        keys = [
          {
            key = "p";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTabRelative(-1)";
          }
          {
            key = "n";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTabRelative(1)";
          }
          {
            key = "N";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.SpawnTab(\"CurrentPaneDomain\") ";
          }
          {
            key = "X";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.CloseCurrentTab({ confirm = false })";
          }
          {
            key = "1";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(0)";
          }
          {
            key = "2";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(1)";
          }
          {
            key = "3";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(2)";
          }
          {
            key = "4";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(3)";
          }
          {
            key = "5";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(4)";
          }
          {
            key = "6";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(5)";
          }
          {
            key = "7";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(6)";
          }
          {
            key = "8";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(7)";
          }
          {
            key = "9";
            mods = "LEADER";
            action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(8)";
          }
        ];
      };

      extraConfig = ''
        wezterm.on("update-right-status", function(window, pane)
          local leader = ""
          if window:leader_is_active() then
            leader = "LEADER"
          end
          window:set_right_status(leader)
        end)
      '';
    };
  };
}
