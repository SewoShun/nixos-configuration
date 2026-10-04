# Brightness listener behind the bar's deflisten. Its store path is written into
# the generated listeners.yuck (modules/programs/eww.nix).
{ pkgs }:
pkgs.writeShellApplication {
  name = "eww-brightness";
  runtimeInputs = with pkgs; [
    brightnessctl
    inotify-tools
    jq
  ];
  text = builtins.readFile ../config/eww-scripts/brightness.sh;
}
