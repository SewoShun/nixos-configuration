# Volume listener behind the bar's deflisten. Its store path is written into
# the generated listeners.yuck (modules/programs/eww.nix).
{ pkgs }:
pkgs.writeShellApplication {
  name = "eww-volume";
  runtimeInputs = with pkgs; [
    coreutils
    gawk
    jq
    pulseaudio
    wireplumber
  ];
  text = builtins.readFile ../config/eww-scripts/volume-state.sh + builtins.readFile ../config/eww-scripts/volume.sh;
}
