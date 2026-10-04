# Network listener behind the bar's deflisten. Its store path is written into
# the generated listeners.yuck (modules/programs/eww.nix).
{ pkgs }:
pkgs.writeShellApplication {
  name = "eww-network";
  runtimeInputs = with pkgs; [
    coreutils
    gawk
    gnugrep
    jq
    networkmanager
  ];
  text = builtins.readFile ../config/eww-scripts/network.sh;
}
