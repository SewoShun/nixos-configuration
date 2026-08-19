{ delib, ... }:
delib.overlayModule {
  name = "sentrux";
  # Vendored from github:SewoShun/sentrux-nix (no longer used as a flake input).
  # sentrux does not build from source; it downloads the prebuilt release binary
  # from sentrux/sentrux's GitHub Releases (x86_64-linux only) and patches it for NixOS.
  overlay = final: prev: {
    sentrux =
      let
        inherit (prev) lib;
        version = "0.5.7";

        # No checksum is published for the release asset, so this was computed
        # by downloading the binary and running sha256sum.
        url = "https://github.com/sentrux/sentrux/releases/download/v${version}/sentrux-linux-x86_64";
        hash = "sha256-Mjf4D+INVKrU3u+ooUPw1gVDu10tatiR60JDLxVXJaY=";

        # eframe/wgpu/winit dlopen() these at runtime rather than linking them
        # at build time, so they never show up in `patchelf --print-needed`.
        runtimeLibs = with prev; [
          libGL
          vulkan-loader
          libxkbcommon
          wayland
          fontconfig
          libx11
          libxcursor
          libxi
          libxrandr
          libxcb
        ];
      in
      prev.stdenv.mkDerivation {
        pname = "sentrux";
        inherit version;

        src = prev.fetchurl { inherit url hash; };

        dontUnpack = true;
        dontConfigure = true;
        dontBuild = true;
        dontStrip = true;

        nativeBuildInputs = with prev; [
          makeWrapper
          autoPatchelfHook
        ];

        # Satisfies the ELF NEEDED entries (libgtk-3, libglib-2.0, libssl,
        # libcrypto, libz, libgcc_s) that autoPatchelfHook resolves.
        buildInputs = with prev; [
          gtk3
          openssl
          zlib
          stdenv.cc.cc.lib
        ];

        installPhase = ''
          runHook preInstall
          install -Dm755 $src $out/bin/sentrux
          runHook postInstall
        '';

        postFixup = ''
          wrapProgram $out/bin/sentrux \
            --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath runtimeLibs}
        '';

        meta = {
          description = "Real-time architectural sensor that helps AI agents close the feedback loop, enabling recursive self-improvement of code quality";
          homepage = "https://github.com/sentrux/sentrux";
          license = lib.licenses.mit;
          mainProgram = "sentrux";
          platforms = [ "x86_64-linux" ];
        };
      };
  };
}
