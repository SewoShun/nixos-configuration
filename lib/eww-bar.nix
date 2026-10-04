# Script that opens the bar on every monitor. Run by the eww service after the
# daemon starts (modules/programs/eww.nix).
{
  pkgs,
  eww,
}:
pkgs.writeShellApplication {
  name = "eww-bar";
  runtimeInputs = with pkgs; [
    coreutils
    eww
    jq
  ];
  text = builtins.readFile ../config/eww-scripts/bar.sh;
}
