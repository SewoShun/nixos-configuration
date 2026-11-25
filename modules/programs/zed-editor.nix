{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.zed-editor;
  inherit (config.my.constants) username;
in
{
  options.my.programs.zed-editor.enable = lib.mkEnableOption "zed-editor";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.zed-editor = {
      enable = true;
      userSettings = {
        helix_mode = true;
        buffer_font_family = "VictorMono Nerd Font";
        terminal.font_family = "VictorMono Nerd Font";
      };
    };
  };
}
