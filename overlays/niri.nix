{ delib, inputs, ... }:
delib.overlayModule {
  name = "niri";
  overlay = inputs.niri.overlays.niri;
}
