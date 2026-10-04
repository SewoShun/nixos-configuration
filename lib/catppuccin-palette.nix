# Extracts the colors of one flavor from the catppuccin palette JSON and
# renders them in the formats that the desktop shell tools consume.
# New output formats are added as further attributes.
{ lib }:
{ palette, flavor }:
let
  colors =
    lib.mapAttrs (_: color: color.hex)
      (lib.importJSON "${palette}/palette.json").${flavor}.colors;
in
{
  inherit colors;

  # GTK CSS `@define-color` declarations, one per palette color
  gtkCss = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: hex: "@define-color ${name} ${hex};") colors
  );

  # SCSS variable declarations, one per palette color
  scss = lib.concatStringsSep "\n" (lib.mapAttrsToList (name: hex: "\$${name}: ${hex};") colors);
}
