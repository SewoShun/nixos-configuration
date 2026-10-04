# Script behind the volume and brightness keys: changes the value and drives
# the eww OSD window. Built here so that niri can reference it directly.
{
  pkgs,
  eww,
  niri,
}:
pkgs.writeShellApplication {
  name = "eww-osd";
  runtimeInputs = with pkgs; [
    brightnessctl
    coreutils
    eww
    gawk
    gnugrep
    jq
    niri
    wireplumber
  ];
  text = builtins.readFile ../config/eww-scripts/volume-state.sh + builtins.readFile ../config/eww-scripts/osd.sh;
}
