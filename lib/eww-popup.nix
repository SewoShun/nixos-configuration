# Script behind the popup keys: toggles an eww popup window. Built here so that
# niri can reference it directly.
{
  pkgs,
  eww,
  niri,
}:
pkgs.writeShellApplication {
  name = "eww-popup";
  runtimeInputs = with pkgs; [
    eww
    gnugrep
    jq
    niri
  ];
  text = builtins.readFile ../config/eww-scripts/popup.sh;
}
