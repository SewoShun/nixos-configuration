{ delib, inputs, ... }:
delib.overlayModule {
  name = "helix";
  overlay = inputs.helix.overlays.helix;
}
