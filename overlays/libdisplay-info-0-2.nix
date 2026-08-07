{ delib, ... }:
delib.overlayModule {
  name = "libdisplay-info-0-2";
  # nixpkgs removed `libdisplay-info_0_2` on 2026-08-04 (see pkgs/top-level/aliases.nix),
  # but niri-flake's niri-stable/niri-unstable packages still hard-require version 0.2.0
  # (`assert libdisplay-info_0_2.version == "0.2.0"`). Restore it until niri-flake adapts.
  overlay = final: prev: {
    libdisplay-info_0_2 = prev.libdisplay-info.overrideAttrs (_: {
      version = "0.2.0";
      src = prev.fetchFromGitLab {
        domain = "gitlab.freedesktop.org";
        owner = "emersion";
        repo = "libdisplay-info";
        rev = "0.2.0";
        sha256 = "sha256-6xmWBrPHghjok43eIDGeshpUEQTuwWLXNHg7CnBUt3Q=";
      };
    });
  };
}
