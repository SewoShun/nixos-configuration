# Workspace listener behind the bar's deflisten. Its store path is written into
# the generated listeners.yuck (modules/programs/eww.nix).
{
  pkgs,
  niri,
}:
pkgs.writeShellApplication {
  name = "eww-workspaces";
  runtimeInputs = with pkgs; [
    coreutils
    jq
    niri
  ];
  text = builtins.readFile ../config/eww-scripts/workspaces.sh;
}
