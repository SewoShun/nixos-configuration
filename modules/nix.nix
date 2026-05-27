{ delib, ... }:
delib.module {
  name = "nix";

  nixos.always = {
    nix = {
      settings = {
        trusted-users = [
          "root"
          "sewo"
        ];
        substituters = [
          "https://nix-community.cachix.org"
          "https://niri.cachix.org"
          "https://sewoshun.cachix.org"
        ];
        trusted-substituters = [
          "https://nix-community.cachix.org"
          "https://niri.cachix.org"
          "https://sewoshun.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
          "sewoshun.cachix.org-1:fYKS0+LekPx7eVOXlqNA3mxx/DVW79hY9NaWOyVCslE="
        ];
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
      };
    };

    programs.nix-ld.enable = true;
  };
}
